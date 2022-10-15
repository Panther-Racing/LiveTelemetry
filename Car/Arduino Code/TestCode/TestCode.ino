#include <SPI.h>
#include <mcp2515.h>
int i = 0;

struct can_frame frame;
//struct can_frame canMsg2;
MCP2515 mcp2515(8);


void setup() {
  pinMode(PD2, INPUT);
  digitalWrite(PD2, HIGH);

  pinMode(PD3, INPUT);
  digitalWrite(PD3, HIGH);

  pinMode(PD4, INPUT);
  digitalWrite(PD4, HIGH);

  pinMode(PD5, INPUT);
  digitalWrite(PD5, HIGH);

  //pinMode(A3, INPUT);
  pinMode(PC0, INPUT);
  //digitalWrite(A3, HIGH);

  while (!Serial);
  Serial.begin(115200);

  mcp2515.reset();
  mcp2515.setBitrate(CAN_1000KBPS, MCP_8MHZ);
  mcp2515.setNormalMode();

  Serial.println("Example: Write to CAN");
}

void message1() {

  //unsigned input = 0x3FF; //placeholder to test message transmission

  //  unsigned input = map(analogRead(PC0), 0, 1023, 0, 255);
  frame.can_id  = 0xE0;
  frame.can_dlc = 8;

  frame.data[0] = 0;
  frame.data[1] = 1;
  frame.data[2] = 2;
  frame.data[3] = 3;
  frame.data[4] = 4;
  frame.data[5] = 5;
  frame.data[6] = 6;

  for(int i = 0; i < 17; i++){
    frame.data[7] = i;
    mcp2515.sendMessage(&frame);
    Serial.println("Message Sent");
  }
  //
  //  unsigned int bitfield = digitalRead(PD2);
  //      bitfield |= digitalRead(PD3) << 1;
  //      bitfield |= digitalRead(PD4) << 2;
  //      bitfield |= digitalRead(PD5) << 3;

  //
  //  frame.data[0] = bitfield;
  //  frame.data[1] = input;




}

//bool message2() {
//  canMsg2.can_id = 0xE0;
//  canMsg2.can_dlc = 8;
//
//  canMsg2.data[0] = 2; //compound id
//
//  bool button1, button2, button3, button4 = false; // buttons
//
//  button1= !digitalRead(PD2);
//  button2= !digitalRead(PD3);
//  button3= !digitalRead(PD4);
//  button4= !digitalRead(PD5);
//
//
//
//  unsigned int bitfield = 0;
//  if(button1) {
//    bitfield += 1;
//  }
//  if(button2) {
//    bitfield += 2;
//  }
//  if(button3) {
//    bitfield += 4;
//  }
//  if(button4) {
//    bitfield += 8;
//  }
//
//  canMsg2.data[7] = bitfield;
//
//  mcp2515.sendMessage(&canMsg2);
//
//}

void loop() {
  message1();
  delay(45);
  //message2();
  //delay(45);
}
