//
//  ScannerViewModel.swift
//  BLEScanner
//
//  Created by Josep Cerdá Penadés on 7/9/25.
//

import Foundation
import CoreBluetooth

final class ScannerViewModel: ObservableObject {

    @Published var peripherals: [UUID: DiscoveredPeripheral] = [:]

    // Throttled publishing
    private var publishTimer: DispatchSourceTimer?
    private let publishInterval: TimeInterval = 0.5
    private var pendingSnapshot: [UUID: DiscoveredPeripheral]? = nil
    private var hasPublishedInitialSnapshot = false

    // MARK: - Private
    private var scanner: BluetoothScannerProtocol

    // MARK: - Init
    init(scanner: BluetoothScannerProtocol) {
        self.scanner = scanner
        self.scanner.delegate = self
    }
}

// MARK: - Public methods

extension ScannerViewModel {
    func onAppear() {
        scanner.start()
        startPublishTimer()
    }

    func onDisappear() {
        scanner.stop()
        stopPublishTimer()
    }

    var discovered: [DiscoveredPeripheral] {
        peripherals.values.sorted { $0.rssi > $1.rssi }
    }
}

// MARK: Timer

private extension ScannerViewModel {
    func startPublishTimer() {
        stopPublishTimer()
        let timer = DispatchSource.makeTimerSource(queue: .main)
        timer.schedule(deadline: .now(), repeating: publishInterval)
        timer.setEventHandler { [weak self] in
            guard let self = self else { return }
            if let snapshot = self.pendingSnapshot {
                self.peripherals = snapshot
                self.pendingSnapshot = nil
            }
        }
        timer.resume()
        publishTimer = timer
    }

    func stopPublishTimer() {
        publishTimer?.cancel()
        publishTimer = nil
    }
}

// MARK: - BluetoothScannerDelegate

extension ScannerViewModel: BluetoothScannerDelegate {
    func scannerDidUpdatePeripherals(_ peripherals: [UUID: DiscoveredPeripheral]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if !self.hasPublishedInitialSnapshot {
                self.peripherals = peripherals
                self.hasPublishedInitialSnapshot = true
            } else {
                self.pendingSnapshot = peripherals
            }
        }
    }

    func scannerDidUpdateState(_ state: CBManagerState,
                               authorization: CBManagerAuthorization) {
        // Optionally react to state/authorization changes (e.g., show banners or update UI flags)
    }
}
