//
//  ViewController.swift
//  MinimalBluetooth
//
//  Created by Jesse Dahl on 2/15/20.
//  Copyright © 2020 Jesse Dahl. All rights reserved.
//
//  This file acts as the main "ViewController" file and will load the first screen for the app.
//  The only real functionality of this file is to call the BTDiscovery.swift file once the user taps on the "connect" button in order to find and connect to the BLE module that is on our vehicle

import UIKit
import CoreBluetooth



// CBCentralManagerDelegate provides updates for the discovery and management of peripheral devices (my HM-10)
// CBPeripheralDelegate provides updates on the use of a peripheral's services

class ViewController: UIViewController {
    
    @IBAction func connectPressed(_ sender: Any) {
        // Object that scans for, discovers, connects to, and manages peripherals once the user taps on the 'connect' button.
        // Look at the BTDiscovery file for more info on that
        _ = btDiscoveryInstance
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    deinit {
      NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: BLEServiceChangedStatusNotification), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      
    }


}

