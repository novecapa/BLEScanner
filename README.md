## WIP!

# 📡 BLE Scanner iOS (SwiftUI)

A **Bluetooth Low Energy (BLE) scanner** for iOS, built with **SwiftUI** and **CoreBluetooth**.  
It detects nearby devices, shows their name, UUID, and signal strength (RSSI in dBm), and keeps the list updated in real-time.

---

## 🚀 Features
- Scan for nearby BLE peripherals.
- Real-time device list with:
  - Device name
  - UUID identifier
  - Signal strength (RSSI in dBm)
  - Last seen timestamp
- Visual signal strength bars.
- Auto-prune devices that have not been seen for a configurable time.
- Modern SwiftUI interface.

---

## 🖼️ Screenshots

## TODO: 
*(Add screenshots here after running the app on a real device)*

---

## 🛠️ Requirements
- iOS 15.0 or later
- Xcode 14+
- Swift 5.7+
- Physical iOS device with Bluetooth enabled (⚠️ does not work on the simulator)

---

## 📦 Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/novecapa/BLEScanner.git
   cd BLEScanner
