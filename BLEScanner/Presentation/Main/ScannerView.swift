//
//  ScannerView.swift
//  BLEScanner
//
//  Created by Josep Cerdá Penadés on 7/9/25.
//

import SwiftUI

struct ScannerView: View {

    // MARK: - Observable
    @ObservedObject var viewModel: ScannerViewModel

    // MARK: - Init
    init(viewModel: ScannerViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Text("BLE Scanner")
                .textScale(.default)
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.discovered) { peripheral in
                        PeripheralCell(peripheral: peripheral)
                    }
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.onAppear()
        }
    }
}

#Preview {
    ScannerViewBuilderMock().build()
}
