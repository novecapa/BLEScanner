//
//  ScannerViewModel.swift
//  BLEScanner
//
//  Created by Josep Cerdá Penadés on 7/9/25.
//

import Foundation
import CoreBluetooth

final class ScannerViewModel: ObservableObject {

    @Published var showLoader: Bool = false
    @Published var peripherals: [UUID: DiscoveredPeripheral] = [:]

    // MARK: Private
    private var scanner: BluetoothScannerProtocol

    // MARK: Init
    init(scanner: BluetoothScannerProtocol) {
        self.scanner = scanner
        self.scanner.delegate = self
    }
}

// MARK: - Public methods

extension ScannerViewModel {
    func onAppear() {
        showLoader = true
        scanner.start()
    }

    func onDisappear() {
        scanner.stop()
        showLoader = false
    }

    var discovered: [DiscoveredPeripheral] {
        Array(peripherals.values).sorted { $0.lastSeen > $1.lastSeen }
    }
}

// MARK: - BluetoothScannerDelegate

extension ScannerViewModel: BluetoothScannerDelegate {
    func scannerDidUpdatePeripherals(_ peripherals: [UUID: DiscoveredPeripheral]) {
        DispatchQueue.main.async { [weak self] in
            self?.peripherals = peripherals
            self?.showLoader = false
        }
    }

    func scannerDidUpdateState(_ state: CBManagerState,
                               authorization: CBManagerAuthorization) {
        // Optionally react to state/authorization changes (e.g., show banners or update UI flags)
    }
}
