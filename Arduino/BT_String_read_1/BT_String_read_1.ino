/** 
 *  Author(s): Jesse Dahl and Keith Lopez
* This file contains the Arduino code that is used to actually control the different components on our vehicle
* This code instantiates the different components connected to our Arduino and reads in serialized data send from our app to the BLE module on the vehicle and parses the data to control the vehicle
* 
* Keith wrote the code to control the different electrical components on the vehicle
* Jesse wrote the code that takes data send from the app and parses it in a way that relays commands send from the app to controlling the components on the vehicle
* 
* Admittedly, I (Jesse) used someone elses code for the song that is played when a user presses the sound button on our app
* Credits for the Imperial March piezo song code goes to: https://gist.github.com/nicksort/4736535
*/

// motor 1
int enA = 10;
int in1 = 9;
int in2 = 8;

// motor 2
int enB = 5;
int in3 = 7;
int in4 = 6;

/**
 * The following constant variables are used to play a 'song' once the sound button is pressed on the app
 */
const int c = 261;
const int d = 294;
const int e = 329;
const int f = 349;
const int g = 391;
const int gS = 415;
const int a = 440;
const int aS = 455;
const int b = 466;
const int cH = 523;
const int cSH = 554;
const int dH = 587;
const int dSH = 622;
const int eH = 659;
const int fH = 698;
const int fSH = 740;
const int gH = 784;
const int gSH = 830;
const int aH = 880;
 
const int buzzerPin = 4;


String readString;

void setup()
{
  Serial.begin(9600);
  pinMode(enA, OUTPUT);
  pinMode(enB, OUTPUT);
  pinMode(in1, OUTPUT);
  pinMode(in2, OUTPUT);
  pinMode(in3, OUTPUT);
  pinMode(in4, OUTPUT);
  pinMode(buzzerPin, OUTPUT);
}

// This loop() function mainly deserializes data from the app and controls the vehicle
void loop()
{
  // This code relies on the Serial package that deserializes the data from the app
  // This loop will continue as long as the Arduino is connected to a BLE module
  while (Serial.available())
  {
    delay(3);
    char c = Serial.read(); // This is used to take serialized inputs from our app and assigns the characters of the inputs to a variable
    readString += c; // Appends new inputs/commanmds to c
  }
  if (readString.length() > 0) // If an input is read in from the app
  {
    // In the app's code the value '180' relates the vehicle moving forward
    // This block of code will make the vehicle move forward
    if (readString == "180")
    {
      digitalWrite(in1, HIGH);
      digitalWrite(in2, LOW);
      // set speed to 200 out of possible range 0~255
      analogWrite(enA, 200);
      // turn on motor B
      digitalWrite(in3, HIGH);
      digitalWrite(in4, LOW);
      // set speed to 200 out of possible range 0~255
      analogWrite(enB, 200);
      delay(2000);
    }
    // In the app's code the value '90' relates the vehicle moving backwards
    // This block of code will make the vehicle move backwards
    else if (readString == "90") {
        digitalWrite(in1, LOW);
        digitalWrite(in2, HIGH); 
        digitalWrite(in3, LOW);
        digitalWrite(in4, HIGH);
        delay(2000);
    }
    // In the app's code the value '0' relates the vehicle stopping
    // This block of code will halt the vehicle
    else if (readString == "0")
    {
      analogWrite(enA, 0);
      analogWrite(enB, 0);
    }
    // In the app's code the value '240' relates the vehicle accelerating
    // This block of code will cause the vehicle to accelerate
    else if (readString == "240") {
      analogWrite(enA, 240);
      analogWrite(enB, 240);
    }
    
    // In the app's code the value '200' relates the vehicle playing a song
    // This block of code will call the functions below in order to play the song
    else if (readString == "200") {
      playSound();
    }
    readString = ""; // Clears the readString variable so more commands can be sent and parsed
  }
}

// This function is used to create a 'beep' sound
void beep(int note, int duration)
{
  //Play tone on buzzerPin
  tone(buzzerPin, note, duration);
 
  //Stop tone on buzzerPin
  noTone(buzzerPin);
 
  delay(50);
 
  //Increment counter
  counter++;
}

// This function is used to play the 'song'
// I chose the Imperial March for the song to play when a user presses the sound button
void playSound()
{
  beep(a, 500);
  beep(a, 500);    
  beep(a, 500);
  beep(f, 350);
  beep(cH, 150);  
  beep(a, 500);
  beep(f, 350);
  beep(cH, 150);
  beep(a, 650);
 
  delay(500);
 
  beep(eH, 500);
  beep(eH, 500);
  beep(eH, 500);  
  beep(fH, 350);
  beep(cH, 150);
  beep(gS, 500);
  beep(f, 350);
  beep(cH, 150);
  beep(a, 650);
 
  delay(500);

    beep(aH, 500);
  beep(a, 300);
  beep(a, 150);
  beep(aH, 500);
  beep(gSH, 325);
  beep(gH, 175);
  beep(fSH, 125);
  beep(fH, 125);    
  beep(fSH, 250);
 
  delay(325);
 
  beep(aS, 250);
  beep(dSH, 500);
  beep(dH, 325);  
  beep(cSH, 175);  
  beep(cH, 125);  
  beep(b, 125);  
  beep(cH, 250);  
 
  delay(350);
}
