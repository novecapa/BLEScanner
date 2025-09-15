//
//  ScannerViewBuilderMock.swift
//  BLEScanner
//
//  Created by Josep Cerdá Penadés on 7/9/25.
//

import CoreBluetooth

final class BluetoothScannerMock: BluetoothScannerProtocol {
    var delegate: (any BluetoothScannerDelegate)?
    var peripherals: [UUID : DiscoveredPeripheral] { [UUID(): .mock] }
    var state: CBManagerState { .poweredOn }
    var authorization: CBManagerAuthorization { .allowedAlways }
    func start() {}
    func stop() {}
    func pruneStale(after seconds: TimeInterval) {}
}

final class ScannerViewBuilderMock {
    func build() -> ScannerView {
        let viewModel = ScannerViewModel(scanner: BluetoothScannerMock())
        let view = ScannerView(viewModel: viewModel)
        return view
    }
}
