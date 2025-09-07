//
//  BluetoothScanner.swift
//  BLEScanner
//
//  Created by Josep Cerdá Penadés on 7/9/25.
//

import CoreBluetooth

protocol BluetoothScannerProtocol {

    var peripherals: [UUID: DiscoveredPeripheral] { get }
    var state: CBManagerState { get }
    var authorization: CBManagerAuthorization { get }

    func start()
    func stop()
    func pruneStale(after seconds: TimeInterval)
}

final class BluetoothScanner: NSObject, ObservableObject {

    @Published private(set) var peripherals: [UUID: DiscoveredPeripheral] = [:]
    @Published private(set) var state: CBManagerState = .unknown
    @Published private(set) var authorization: CBManagerAuthorization = .notDetermined

    private var central: CBCentralManager!
    private let queue = DispatchQueue(label: "ble.scanner.queue")

    override init() {
        super.init()
        central = CBCentralManager(delegate: self, queue: queue)
        authorization = CBManager.authorization
    }

    private func upsertPeripheral(_ peripheral: CBPeripheral,
                                  name: String?,
                                  rssi: NSNumber) {
        let id = peripheral.identifier
        let newItem = DiscoveredPeripheral(
            id: id,
            name: name?.isEmpty == false ? name! : "Unknown",
            rssi: rssi.intValue,
            lastSeen: Date()
        )

        DispatchQueue.main.async {
            var existing = self.peripherals[id]
            existing?.name = newItem.name
            existing?.rssi = newItem.rssi
            existing?.lastSeen = newItem.lastSeen
            self.peripherals[id] = existing ?? newItem
        }
    }
}

// MARK: - BluetoothScannerProtocol

extension BluetoothScanner: BluetoothScannerProtocol {
    func start() {
        queue.async { [weak self] in
            guard let self else { return }
            if self.state == .poweredOn {
                self.central.scanForPeripherals(
                    withServices: nil,
                    options: [CBCentralManagerScanOptionAllowDuplicatesKey: true]
                )
            }
        }
    }

    func stop() {
        queue.async { [weak self] in self?.central.stopScan() }
    }

    /// Optional: clear old devices
    func pruneStale(after seconds: TimeInterval = 10) {
        let cutoff = Date().addingTimeInterval(-seconds)
        DispatchQueue.main.async {
            self.peripherals = self.peripherals.filter { $0.value.lastSeen >= cutoff }
        }
    }
}


// MARK: - CBCentralManagerDelegate

extension BluetoothScanner: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        authorization = CBManager.authorization
        state = central.state

        switch central.state {
        case .poweredOn:
            central.scanForPeripherals(
                withServices: nil,
                options: [CBCentralManagerScanOptionAllowDuplicatesKey: true]
            )
        default:
            central.stopScan()
            DispatchQueue.main.async { self.peripherals.removeAll() }
        }
    }

    func centralManager(_ central: CBCentralManager,
                        didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any],
                        rssi RSSI: NSNumber) {

        // Get RSSI from `didDiscover`
        let name = peripheral.name ?? (advertisementData[CBAdvertisementDataLocalNameKey] as? String)
        upsertPeripheral(peripheral, name: name, rssi: RSSI)
    }
}
