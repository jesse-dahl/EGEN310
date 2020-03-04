//
//  TransitionSegue.swift
//  MinimalBluetooth
//
//  Created by Jesse Dahl on 3/3/20.
//  Copyright © 2020 Jesse Dahl. All rights reserved.
//

import UIKit

class TransitionSegue: UIStoryboardSegue {
    override func perform() {
        source.navigationController?.setViewControllers([destination], animated: true)
    }
}
