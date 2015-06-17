
// compiler error handling
#include "Compiler_Errors.h"

// touch includes
#include <MPR121.h>
#include <Wire.h>
#define MPR121_ADDR 0x5C
#define MPR121_INT 4

// touch behaviour definitions
#define firstPin 0
#define lastPin 11

// define LED_BUILTIN for older versions of Arduino
#ifndef LED_BUILTIN
#define LED_BUILTIN 13
#endif

void setup() {
  Serial.begin(57600);

  pinMode(LED_BUILTIN, OUTPUT);

  //while (!Serial) ; {} //uncomment when using the serial monitor
  Serial.println("Bare Conductive Touch MP3 player");

  if (!MPR121.begin(MPR121_ADDR)) Serial.println("error setting up MPR121");
  MPR121.setInterruptPin(MPR121_INT);

  MPR121.setTouchThreshold(2);
  // this is the release threshold - must ALWAYS be smaller than the touch threshold
  // default value is 20 for touch
  MPR121.setReleaseThreshold(1);
}

void loop() {
  readTouchInputs();
}


void readTouchInputs()
{
  if (MPR121.touchStatusChanged())
  {
    MPR121.updateTouchData();
        
    if (MPR121.isNewTouch(0))
    {
      Serial.print(1);
      digitalWrite(LED_BUILTIN, HIGH);
    }

    if (MPR121.isNewRelease(0))
    {
      Serial.print(0);
      digitalWrite(LED_BUILTIN, LOW);
    }
  }
}
