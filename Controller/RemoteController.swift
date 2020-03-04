//
//  RemoteController.swift
//  MinimalBluetooth
//
//  Created by Jesse Dahl on 3/3/20.
//  Copyright © 2020 Jesse Dahl. All rights reserved.
//

import UIKit

class RemoteController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func upButtonPressed(_ sender: Any) {
        print("Up button pressed");
    }
    
    @IBAction func downButtonPressed(_ sender: Any) {
        print("Down button pressed");
    }
    
    @IBAction func leftButtonPressed(_ sender: Any) {
        print("Left button pressed");
    }
    
    @IBAction func rightButtonPressed(_ sender: Any) {
        print("Right button pressed");
    }
}
