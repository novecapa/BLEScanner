//
//  ScannerView.swift
//  BLEScanner
//
//  Created by Josep Cerdá Penadés on 7/9/25.
//

import SwiftUI

struct ScannerView: View {

    // MARK: Private

    @ObservedObject var viewModel: ScannerViewModel

    // MARK: Init

    init(viewModel: ScannerViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("Scanner")
                .textScale(.default)
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.discovered) { peripheral in
                        HStack {
                            Text(peripheral.name)
                                .foregroundStyle(.blue)
                            Spacer()
                            Text(peripheral.rssi.toString)
                                .foregroundStyle(.green)
                        }
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

// MARK: - ScannerView

extension ScannerView {
    
}

#Preview {
    ScannerViewBuilderMock().build()
}
