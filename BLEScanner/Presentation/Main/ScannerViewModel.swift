//
//  ScannerViewModel.swift
//  BLEScanner
//
//  Created by Josep Cerdá Penadés on 7/9/25.
//

import Foundation

final class ScannerViewModel: ObservableObject {

    @Published var showLoader: Bool = false
    @Published var peripherals: [DiscoveredPeripheral] = []

    // MARK: Private
    private let scanner: BluetoothScannerProtocol

    // MARK: Init
    init (scanner: BluetoothScannerProtocol) {
        self.scanner = scanner
    }
}

// MARK: - Public methods

extension ScannerViewModel {
    
}
