//
//  DiscoveredPeripheral.swift
//  BLEScanner
//
//  Created by Josep Cerdá Penadés on 7/9/25.
//

import Foundation

struct DiscoveredPeripheral: Identifiable, Hashable {
    let id: UUID
    var name: String
    var rssi: Int
    var lastSeen: Date

    static func == (lhs: Self, rhs: Self) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}

extension DiscoveredPeripheral {
    static let mock: DiscoveredPeripheral = DiscoveredPeripheral(
        id: UUID(),
        name: "Mock",
        rssi: -46,
        lastSeen: Date()
    )
}
