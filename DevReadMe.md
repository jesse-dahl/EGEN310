## This ReadMe is meant for a developer that would like to know more about how the app works and how to change the code of the app
**If you are a user that has no software development experience, please refer to the basic ReadMe.md file**

The app is composed of the Swift files that you will find in this repository. Here is the basic flow of the app:

1. The app starts off with the ViewController.swift file

      1a) This file is paired with the Main.storyboard file for the UI. Once the user taps on the "Connect" button, the IBAction function "connectPressed" is called and it creates an object from the BTDiscovery file.
2. If you visit the BTDiscovery.swift file, you will find in my comments that this file is in charge of finding, connecting to, and disconnecting from a BLE module.

      2a) This app uses Apple's CoreBluetooth package to actually do the heavy lifting of searching for and connecting to a BLE module. More info on CoreBluetooth can be found here: https://developer.apple.com/documentation/corebluetooth

      2b) This file starts out by using CoreBluetooth to search for a BLE module that matches the UUID (Universally Unique IDentifier) of the BLE module on our team's vehicle. This UUID code is found in the BTService.swift file (which takes care of all the security and most of the error handling for the BTDiscovery.swift file). If you want to connect this app to your own BLE module, simply go to the BTService.swift file and change the BLEServiceUUID and PositionCharUUID variables to those of your module's unique information

      2c) Within the BTDiscovery.swift file, the app starts scanning for BLE modules. If one is found that has the UUID that you have in the BTService.swift file, the first centralManager function will be called to validate information and conneect to the BLE module. Then the second centralManager function is called to stop the app from scanning for more devices. If the app disconnects from the BLE module, the third centralManager function will be called to start searching for more devices. **I do not recommend changing anything within this file since everything works exactly as anyone would intend it to**

3. Once the app connects to the BLE module, the user will be redirected to the second storyboard, or UI screen. This is the actual controller for the app. Go to the Controller.storyboard file to view or edit the UI for this screen. The code that controls this screen is located in the RemoteController.swift file

      3a) Basically, this file consists of IBAction buttons (the buttons that you see on the Controller.storyboard UI). Each time a button is pressed on the UI, the function within the code that is mapped to that button will be called. All of these buttons consist of another function call to the sendPosition() function within the same file. The parameter being passed to sendPosition() is of type UInt8 which is an unsigned integer number stored with 8 bits (only values between 0 and 255 are accepted). These integers are passed to the sendPosition() function to be sent to the BLE module to be parsed within the Arduino code. the sendPosition() function creates an object from the BTService class, where the values are sent to the BLE module using the writePosition() function in the BTService class. The sendPosition() function also contains a timer that ensures that the user doesn't send too many commands to the BLE nodule in order to ensure that the module doesn't get flooded with commands.

      3b) If you would like to change anything within this file, you would do so by changing the values that are being passed to the sendPosition() function by each button. However, if you do this you would also have to go into the Arduino code to make the same changes that you made within the swift file. 


That is the basic overview of the app and how it works. If you would like more info on how each funciton works, I commented the code to allow developers to understand what each function does. Some research may have to be done to understand more (for instance, to understand how CoreBluetooth works, you will have to visit Apple's official documentation).