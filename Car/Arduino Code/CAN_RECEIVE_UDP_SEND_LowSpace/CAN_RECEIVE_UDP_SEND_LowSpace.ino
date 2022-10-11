//Receive a CAN message and output as a string to UDP
//Written by Yahya Farag
#include <SPI.h>             
#include <mcp2515.h>        
#include <Ethernet.h>       
#include <EthernetUdp.h>    

struct can_frame canMsg;
MCP2515 mcp2515(8);                

byte mac[] = {0xB8, 0xCA, 0x3A, 0x8B, 0x3B, 0xC6}; 

EthernetUDP Udp; 

void setup() {
  //intialize MCP 2515 board
  SPI.begin();      
  mcp2515.reset();   
  mcp2515.setBitrate(CAN_1000KBPS, MCP_8MHZ);
  mcp2515.setNormalMode();

  //Configure CS pin for Ethernet
  Ethernet.init(9); 

  //Initialize UDP functionalities 
  Ethernet.begin(mac); //begin ethernet with mac adress input above setup
  // start UDP on local port set to "listen" on
  Udp.begin(8888); 
}

//Receives messages from CAN bus and ouput in string form ("canId,CanLength,data1, data2, data 3,....."), if error reading bus outputs "?" to indicate message not in CAN form
void loop() {
  if (mcp2515.readMessage(&canMsg) == MCP2515::ERROR_OK) // To receive data (Poll Read)
  {
    String str = "";
    str += canMsg.can_id; //write CAN message ID to string
    str += ",";
    str += canMsg.can_dlc;//write CAN Message length to string
    str += ",";
    for(char num : canMsg.data){ //go through all the data points using the dlc(length output recieved on line 30) to print out all the data points
      str += num+",";
    }

    //Send UDP packet with values put into str (old udpSend method)
    Udp.beginPacket("raheelfarouk.tplinkdns.com", 20001); //prepare to send packet in form of EthernetUDP.beginPacket(remoteIP, remotePort);
    int len=str.length();
    char Buf[len]; //create char array with length of CAN message
    str.toCharArray(Buf,len); //convert can Message string into char array
    Udp.write(Buf); //output char array to UDP
    Udp.endPacket(); //end the packet
  }
}

