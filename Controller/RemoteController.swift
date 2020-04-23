//
//  RemoteController.swift
//  MinimalBluetooth
//
//  Created by Jesse Dahl on 3/3/20.
//  Copyright © 2020 Jesse Dahl. All rights reserved.
//
//  This file acts as the main functionality of the app. This will file basically controls the car by sending our Arduino specific signals to control the different components on the vehicle.

import UIKit

class RemoteController: UIViewController {
    var timerTXDelay: Timer?
    var allowTX = true
    var lastPosition: UInt8 = 255
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // This is tied to the stop button. Once it is pressed, the vehicle will halt
    @IBAction func stopButtonPressed(_ sender: Any) {
        self.sendPosition(UInt8(0));
    }
    
    // This is tied to the "up button". Once it is pressed, the vehicle will move forward
    @IBAction func upButtonPressed(_ sender: Any) {
        self.sendPosition(UInt8(180));
        print("Up button pressed");
    }
    
    // This is tied to the "accelerate" button. Once it is pressed, the vehicle will move faster
    @IBAction func accelerateButtonPressed(_ sender: Any) {
        self.sendPosition(UInt8(240));
    }
    
    // This is tied to the "down button". Once it is pressed, the vehicle will move backwards
    @IBAction func downButtonPressed(_ sender: Any) {
        self.sendPosition(UInt8(90));
    }
    
    @IBAction func leftButtonPressed(_ sender: Any) {
        print("Left button pressed");
    }
    
    @IBAction func rightButtonPressed(_ sender: Any) {
        print("Right button pressed");
    }
    
    // This function sends the data from each button being pressed over to the Arduino for components to be controlled
    func sendPosition(_ position: UInt8) {
      
        // Only continue if no other send occurred in the last 0.1 seconds to avoid flooding the BLE connections
        if !allowTX {
            return
        }
        
        // Prevent the same value from being written multiple times. To keep traffic and power use to a minimum
        if position == lastPosition {
            return
        }
        
        // Make sure the values being sent are in the correct range
        else if ((position <= 0) || (position > 255)) {
            return
        }
        
        // Ensure that the BTSerice exists and is ready, then write the position value to the position characteristic
        let bleService = btDiscoveryInstance.bleService;
        bleService!.writePosition(position);
        if let bleService = btDiscoveryInstance.bleService {
            bleService.writePosition(position);
            lastPosition = position;

            // Timer to prevent from flooding
            allowTX = false;
            if timerTXDelay == nil {
              timerTXDelay = Timer.scheduledTimer(timeInterval: 0.1,
                target: self,
                selector: #selector(RemoteController.timerTXDelayElapsed),
                userInfo: nil,
                repeats: false)
            }
        }
        
      
    }
    
    // This function along with the stopTimerTXDelay() function will reset the timer to allow a user to send more commands
    @objc func timerTXDelayElapsed() {
      self.allowTX = true
      self.stopTimerTXDelay()
    }
    
    func stopTimerTXDelay() {
      if self.timerTXDelay == nil {
        return
      }
      
      timerTXDelay?.invalidate()
      self.timerTXDelay = nil
    }
}
