## This ReadMe is for a non-developer that would attempt to use this app
**If you are a developer that would like to learn more about how this app works, read the DevReadME.md file**

**Before you begin to use this app, there are a few prerequisites that you need to fulfill. These prerequisites are listed below:**

### Prerequisites:
1. Mac computer to open the code and upload it to your phone
2. XCode to upload the app
3. iPhone
4. Either E.4.'s vehicle or a vehicle of your own that you will have to wire everything up according to our Arduino code, along with an Arduino to upload our Arduino code to
5. If you don't have our team's vehicle, you will also need to connect an HM-10 BLE module to your vehicle and change the UUID in the BTService.swift file to that of your personal HM-10 BLE module's UUID

### Using the app:

Once you have all the prerequisites met, using our app is very simple

1. Open the app
2. Press the connect button to connect to the BLE module on the vehicle
3. Once you are connected to the BLE module on the vehicle, you will be redirected to the controller app
4. Everything on this controller is pretty self explanatory:
  * Press the up arrow button to move forward
  * Press the down arrow button to move backwards
  * Press the left arrow button to move left
  * Press the right arrow button to move right
  * Press the stop icon at the top to stop your vehicle
  * Press the sound icon to play a 'song' that is coded in our Arduino code
  * Press the speedometer icon to accelerate the vehicle