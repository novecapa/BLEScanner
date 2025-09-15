//
//  PeripheralCell.swift
//  BLEScanner
//
//  Created by Josep Cerdá Penadés on 13/9/25.
//

import SwiftUI

struct PeripheralCell: View {

    // MARK: - Private
    private let peripheral: DiscoveredPeripheral

    // MARK: - Init
    init(peripheral: DiscoveredPeripheral) {
        self.peripheral = peripheral
    }

    var body: some View {
        HStack {
            Text(peripheral.name)
                .foregroundStyle(.blue)
            Spacer()
            Text(peripheral.rssi.toString)
                .foregroundStyle(.green)
        }
        .padding(16)
        .background(Color.gray.opacity(0.2))
    }
}

#Preview {
    PeripheralCell(peripheral: .mock)
}
