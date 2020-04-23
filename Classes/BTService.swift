//
//  BTService.swift
//  MinimalBluetooth
//
//  Created by Jesse Dahl on 3/7/20.
//  Copyright © 2020 Jesse Dahl. All rights reserved.
//
//  This file is used to store private information used to connect to the BLE module in the BTDiscovery file. It also takes care of some security and edge cases for possible errors

import Foundation
import CoreBluetooth

/* Services & Characteristics UUIDs for the BLE module on the vehicle*/
let BLEServiceUUID = CBUUID(string: "0000ffe0-0000-1000-8000-00805f9b34fb")
let PositionCharUUID = CBUUID(string: "0000ffe1-0000-1000-8000-00805f9b34fb")
let BLEServiceChangedStatusNotification = "kBLEServiceChangedStatusNotification"

class BTService: NSObject, CBPeripheralDelegate {
  var peripheral: CBPeripheral?
  var positionCharacteristic: CBCharacteristic?
  
  init(initWithPeripheral peripheral: CBPeripheral) {
    super.init()
    
    self.peripheral = peripheral
    self.peripheral?.delegate = self
  }
  
  deinit {
    self.reset()
  }
  
  func startDiscoveringServices() {
    self.peripheral?.discoverServices([BLEServiceUUID])
  }
  
  func reset() {
    if peripheral != nil {
      peripheral = nil
    }
    
    // Deallocating therefore send notification
    self.sendBTServiceNotificationWithIsBluetoothConnected(false)
  }
  
  // Mark: - CBPeripheralDelegate
  
  func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
    let uuidsForBTService: [CBUUID] = [PositionCharUUID]
    
    if (peripheral != self.peripheral) {
      // Wrong Peripheral
      return
    }
    
    if (error != nil) {
      return
    }
    
    if ((peripheral.services == nil) || (peripheral.services!.count == 0)) {
      // No Services
      return
    }
    
    for service in peripheral.services! {
      if service.uuid == BLEServiceUUID {
        peripheral.discoverCharacteristics(uuidsForBTService, for: service)
      }
    }
  }
  
    // This function
  func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
    if (peripheral != self.peripheral) {
      // Wrong Peripheral
      return
    }
    
    if (error != nil) {
      return
    }
    
    if let characteristics = service.characteristics {
      for characteristic in characteristics {
        if characteristic.uuid == PositionCharUUID {
          self.positionCharacteristic = (characteristic)
          peripheral.setNotifyValue(true, for: characteristic)
          
          // Send notification that Bluetooth is connected and all required characteristics are discovered
          self.sendBTServiceNotificationWithIsBluetoothConnected(true)
        }
      }
    }
  }
  
  func writePosition(_ position: UInt8) {
    // See if characteristic has been discovered before writing to it
    if self.positionCharacteristic != nil {
        let data = Data(bytes: [position])
        self.peripheral?.writeValue(data, for: positionCharacteristic!, type: CBCharacteristicWriteType.withResponse)
    }
    
  }
  
    // This function should send the user of the app a notification when the app connects to the BLE module
  func sendBTServiceNotificationWithIsBluetoothConnected(_ isBluetoothConnected: Bool) {
    let connectionDetails = ["isConnected": isBluetoothConnected]
    NotificationCenter.default.post(name: Notification.Name(rawValue: BLEServiceChangedStatusNotification), object: self, userInfo: connectionDetails)
  }
  
}
