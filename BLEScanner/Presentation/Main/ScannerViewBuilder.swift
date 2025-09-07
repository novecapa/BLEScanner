//
//  ScannerViewBuilder.swift
//  BLEScanner
//
//  Created by Josep Cerdá Penadés on 7/9/25.
//

import Foundation

final class ScannerViewBuilder {
    func build() -> ScannerView {
        let scanner: BluetoothScannerProtocol = BluetoothScanner()
        let viewModel = ScannerViewModel(scanner: scanner)
        let view = ScannerView(viewModel: viewModel)
        return view
    }
}
