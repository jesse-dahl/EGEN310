//
//  ViewController.swift
//  MinimalBluetooth
//
//  Created by Jesse Dahl on 2/15/20.
//  Copyright © 2020 Jesse Dahl. All rights reserved.
//

import UIKit
import CoreBluetooth



// CBCentralManagerDelegate provides updates for the discovery and management of peripheral devices (my HM-10)
// CBPeripheralDelegate provides updates on the use of a peripheral's services

class ViewController: UIViewController, CBPeripheralDelegate, CBCentralManagerDelegate {
    private var centralManager: CBCentralManager!
    private var peripheral: CBPeripheral!
    
    //Text variable that appears when user presses connect button
    @IBOutlet weak var searchText: UILabel!
    
    // function that updates when the Bluetooth Peripheral is switched on or off. Scanning starts here
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("Central state update");
        if central.state != .poweredOn {
            print("Central is not powered on");
        } else {
            print("Central scanning for Bluetooth modules");
            searchText.text = "Searching for Bluetooth devices...";
            //Scans for bluetooth devices with UUID FFE0
            centralManager.scanForPeripherals(withServices: [CBUUID(string: "FFE0")], options: nil);
        }
    }
    
    //Function that handles the rest of the scan
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        
        // We found the device!
        self.centralManager.stopScan();
        
        // Copy the peripheral instance
        self.peripheral = peripheral;
        self.peripheral.delegate = self;
        
        // Connect!
        self.centralManager.connect(self.peripheral, options: nil);
        
        // handler that double checks that you ar working with the correct device
        if peripheral == self.peripheral {
            print("Connected to HM-10 Module");
            peripheral.discoverServices([CBUUID(string: "FFE0")]);
        }
    }
    
    @IBAction func connectPressed(_ sender: Any) {
                // Object that scans for, discovers, connects to, and manages peripherals
        centralManager = CBCentralManager(delegate: self, queue: nil);
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

//        centralManager = CBCentralManager(delegate: self, queue: nil);
    }


}

