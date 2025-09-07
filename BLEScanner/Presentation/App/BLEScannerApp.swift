//
//  BLEScannerApp.swift
//  BLEScanner
//
//  Created by Josep Cerdá Penadés on 7/9/25.
//

import SwiftUI

@main
struct BLEScannerApp: App {
    var body: some Scene {
        WindowGroup {
            ScannerViewBuilder().build()
        }
    }
}
