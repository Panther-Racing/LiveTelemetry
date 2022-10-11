//Receive a CAN message and output as a string to UDP
//Written by Yahya Farag
#include <SPI.h>              //Library for using SPI Communication 
#include <mcp2515.h>          //Library for using CAN Communication (https://github.com/autowp/arduino-mcp2515/)
#include <Ethernet.h>         //Library for using Ethernet (https://www.arduino.cc/reference/en/libraries/ethernet/)
#include <EthernetUdp.h>      //Library for sending UDP packets over ethernet

struct can_frame canMsg; // Can message structure for using all CAN functionalities
MCP2515 mcp2515(8);                 // SPI CS Pin 10

byte mac[] = {0xB8, 0xCA, 0x3A, 0x8B, 0x3B, 0xC6}; //mac adress of output device
IPAddress ip(192, 168, 1, 177); //ip adress of output device
unsigned int localPort = 8888;      // local port to listen on

char packetBuffer[UDP_TX_PACKET_MAX_SIZE];  // buffer to hold incoming packet,

EthernetUDP Udp; //DecleareEthernet udp structure for udp/ethernet functionalities

void setup() {
 while (!Serial);
  Serial.begin(115200);       //begin Serial Monitor at baud rate of 115200
  canInitialize(); //intialize mcp 2515 and CAN bus
  Ethernet.init(9);  // tie ethernet to pin 10 !!!! Must change interfears witjh MCP board (This shpuld be moved into udpInitalize() once resolved)
  udpInitialize(); // Initialize udp and ethernet functionalities
  Serial.println("Bootup");
}
void loop() {
  String tempCANstr = canRead(checkBus(canMsg)); //put CAN message into String to then be given to UDP
  if(tempCANstr!= "?"){ //checking if output str is a valid CAN message format
    //Send UDP Packet
    udpSend(tempCANstr); //send CAN messageon UDP
  }
}
//intialize MCP 2515 board
void canInitialize(){
  SPI.begin();               //Begins SPI communication 
  mcp2515.reset();           //reset the board
  mcp2515.setBitrate(CAN_1000KBPS, MCP_8MHZ); //Sets CAN at speed 500KBPS and Clock 8MHz
  mcp2515.setNormalMode();   //set mcp25515 mode to normal
}
//Initialize UDP functionalities
void udpInitialize(){
  Ethernet.begin(mac); //begin ethernet with mac adress input above setup

  if (Ethernet.linkStatus() == LinkOFF) { //check if ethernet cable is fully connected and able to send data
    Serial.println("Ethernet cable is not connected.");
  }
  // start UDP on local port set to "listen" on
  Udp.begin(localPort);
}
//Check if BUS is active
bool checkBus(struct can_frame cn){
  if(mcp2515.readMessage(&cn) == MCP2515::ERROR_OK){
   return true;
  }
  return false;
}
//Receives messages from CAN bus and ouput in string form ("canId,CanLength,data1, data2, data 3,....."), if error reading bus outputs "?" to indicate message not in CAN form
String canRead(bool bol){
  if (mcp2515.readMessage(&canMsg) == MCP2515::ERROR_OK) // To receive data (Poll Read)
  {
    String str = "";
    str += canMsg.can_id; //write CAN message ID to string
    str += ",";
    str += canMsg.can_dlc;//write CAN Message length to string
    str += ",";
    for(int i = 0; i < canMsg.can_dlc; i++){ //go through all the data points using the dlc(length output recieved on line 30) to print out all the data points
      str += canMsg.data[i];
      str += ",";
    }
    return str;
  }
  return "?";

}
//Send UDP packet with values put into canM
void udpSend(String canM){
  Udp.beginPacket("raheelfarouk.tplinkdns.com", 20001); //prepare to send packet in form of EthernetUDP.beginPacket(remoteIP, remotePort);
  char Buf[canM.length()]; //create char array with length of CAN message
  canM.toCharArray(Buf,canM.length()); //convert can Message string into char array
  Udp.write(Buf); //output char array to UDP
  Udp.endPacket(); //end the packet
}


