//
//  BTDiscovery.swift
//  MinimalBluetooth
//
//  Created by Jesse Dahl on 3/7/20.
//  Copyright © 2020 Jesse Dahl. All rights reserved.
//
//  This file is in charge of actually finding, connecting to, and disconnecting from BLE modules

import Foundation
import UIKit
import CoreBluetooth

let btDiscoveryInstance = BTDiscovery();

class BTDiscovery: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    private var centralManager: CBCentralManager!
    private var peripheralBLE: CBPeripheral!
        
      override init() {
      super.init()
      
      centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    // This function will begin to start looking for a BLE module with a UUID that matches that of the UUID for the BLE module on the vehicle
    func startScanning() {
      if let central = centralManager {
        central.scanForPeripherals(withServices: [BLEServiceUUID], options: nil)
      }
    }
    
    var bleService: BTService? {
      didSet {
        if let service = self.bleService {
          service.startDiscoveringServices()
        }
      }
    }
    
    // MARK: - CBCentralManagerDelegate
    
    // This function is called if a BLE module with a UUID matching that of the one on the vehicle is found. Once it is found, it will connect to the BLE module
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
      // Be sure to retain the peripheral or it will fail during connection.
      
      // Validate peripheral information
      if ((peripheral.name == nil) || (peripheral.name == "")) {
        return
      }
      
      // If not already connected to a peripheral, then connect to this one
      if ((self.peripheralBLE == nil) || (self.peripheralBLE?.state == CBPeripheralState.disconnected)) {
        // Retain the peripheral before trying to connect
        self.peripheralBLE = peripheral
        
        // Reset service
        self.bleService = nil
        
        // Connect to peripheral
        central.connect(peripheral, options: nil)
      }
    }
    
    // This function is called when the app connects to the BLE module. Once it connects, the app will stop searching for BLE signals
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
      
      // Create new service class
      if (peripheral == self.peripheralBLE) {
        self.bleService = BTService(initWithPeripheral: peripheral)
      }
      
      // Stop scanning for new devices
      central.stopScan()
    }
    
    // This function is called once the app disconnects from the previously connected BLE module. Once it disconnects, it starts searching for more BLE modules
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
      
      // See if it was our peripheral that disconnected
      if (peripheral == self.peripheralBLE) {
        self.bleService = nil;
        self.peripheralBLE = nil;
      }
      
      // Start scanning for new devices
      self.startScanning()
    }
    
    // This function will clear the queue for BLE modules to prevent from overloading of data and devices
    func clearDevices() {
      self.bleService = nil
      self.peripheralBLE = nil
    }
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
      switch (central.state) {
      case .poweredOff:
        self.clearDevices()
        
      case .unauthorized:
        // Indicate to user that the iOS device does not support BLE.
        break
        
      case .unknown:
        // Wait for another event
        break
        
      case .poweredOn:
        self.startScanning()
        
      case .resetting:
        self.clearDevices()
        
      case .unsupported:
        break
      }
    }
}
