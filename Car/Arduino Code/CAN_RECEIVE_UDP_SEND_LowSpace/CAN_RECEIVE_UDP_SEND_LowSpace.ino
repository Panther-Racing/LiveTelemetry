//Receive a CAN message and output as a string to UDP
//Written by Yahya Farag
#include <SPI.h>             
#include <mcp2515.h>        
#include <Ethernet.h>       
#include <EthernetUdp.h>    

struct can_frame canMsg;
MCP2515 mcp2515(10);                

byte mac[] = {0xB8, 0xCA, 0x3A, 0x8B, 0x3B, 0xC6}; 
IPAddress ip(192, 168, 1, 177); 
unsigned int localPort = 8888;    

char packetBuffer[UDP_TX_PACKET_MAX_SIZE]; 

EthernetUDP Udp; 

void setup() {
  canInitialize();
  Ethernet.init(9);  
  udpInitialize(); 
}
void loop() {
  String tempCANstr = canRead(checkBus(canMsg)); 
  if(tempCANstr!= "?"){ 
    
    udpSend(tempCANstr); 
  }
}
//intialize MCP 2515 board
void canInitialize(){
  SPI.begin();      
  mcp2515.reset();   
  mcp2515.setBitrate(CAN_1000KBPS, MCP_8MHZ);
  mcp2515.setNormalMode();
}
//Initialize UDP functionalities
void udpInitialize(){
  Ethernet.begin(mac); //begin ethernet with mac adress input above setup

  if (Ethernet.linkStatus() == LinkOFF) { //check if ethernet cable is fully connected and able to send data
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


