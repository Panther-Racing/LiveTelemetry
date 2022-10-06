// Receive all incoming CAN_BUS Coms through mcp 2515 chipset
//Written by Yahya Farag
#include <SPI.h>              //Library for using SPI Communication 
#include <mcp2515.h>          //Library for using CAN Communication (https://github.com/autowp/arduino-mcp2515/)

struct can_frame canMsg;
 
MCP2515 mcp2515(10);                 // SPI CS Pin 10
 
 
void setup()
{
  Serial.begin(115200);                //Begins Serial Communication at 115200 baudrate
  Serial.flush();
  SPI.begin();                       //Begins SPI communication
  Serial.println("CANBUS OUTPUT: ");
  mcp2515.reset();
  mcp2515.setBitrate(CAN_1000KBPS, MCP_8MHZ); //Sets CAN at speed 1000BPS and Clock 8MHz
  mcp2515.setNormalMode();                  //Sets CAN at normal mode
  Serial.println("ID   DlC   DATA");
  delay(3000);
}
 
void loop()
{
  recieveMessage();
}

void recieveMessage(){
  if (mcp2515.readMessage(&canMsg) == MCP2515::ERROR_OK) // To receive data (Poll Read)
  {
    Serial.print(canMsg.can_id);
    Serial.print("     ");
    Serial.print(canMsg.can_dlc);
    Serial.print("   ");
    for(int i = 0; i<canMsg.can_dlc; i++){ //go through all the data points using the dlc(length output recieved on line 30) to print out all the data points
      Serial.print(canMsg.data[i]);
      Serial.print("  ");
    }
    Serial.println();
  }
  return;
}
