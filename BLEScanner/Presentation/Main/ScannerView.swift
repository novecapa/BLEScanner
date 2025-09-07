//
//  ScannerView.swift
//  BLEScanner
//
//  Created by Josep Cerdá Penadés on 7/9/25.
//

import SwiftUI

struct ScannerView: View {

    // MARK: Private
    private let viewModel: ScannerViewModel

    // MARK: Init
    init(viewModel: ScannerViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ScannerViewBuilderMock().build()
}
