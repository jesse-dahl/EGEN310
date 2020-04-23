## This ReadMe is meant for a developer that would like to know more about how the app works and how to change the code of the app
**If you are a user that has no software development experience, please refer to the basic ReadMe.md file**

The app is composed of the Swift files that you will find in this repository. Here is the basic flow of the app:

1. The app starts off with the ViewController.swift file

  ⋅⋅⋅1a) This file is paired with the Main.storyboard file for the UI. Once the user taps on the "Connect" button, the IBAction function "connectPressed" is called and it creates an object from the BTDiscovery file.
2. If you visit the BTDiscovery.swift file, you will find in my comments that this file is in charge of finding, connecting to, and disconnecting from a BLE module.

 a) This app uses Apple's CoreBluetooth package to actually do the heavy lifting of searching for and connecting to a BLE module. More info on CoreBluetooth can be found here: https://developer.apple.com/documentation/corebluetooth

 b) This file starts out by using CoreBluetooth to search for a BLE module that matches the UUID (Universally Unique IDentifier) of the BLE module on our team's vehicle. This UUID code is found in the BTService.swift file (which takes care of all the security and most of the error handling for the BTDiscovery.swift file). If you want to connect this app to your own BLE module, simply go to the BTService.swift file and change the BLEServiceUUID and PositionCharUUID variables to those of your module's unique information
