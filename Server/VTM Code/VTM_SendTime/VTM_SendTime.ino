//Receive a CAN message and output as a string to UDP
#include <SPI.h>              //Library for using SPI Communication 
#include <mcp2515.h>          //Library for using CAN Communication (https://github.com/autowp/arduino-mcp2515/)
#include <Ethernet.h>         //Library for using Ethernet (https://www.arduino.cc/reference/en/libraries/ethernet/)
#include <EthernetUdp.h>      //Library for sending UDP packets over ethernet

//int status = WL_IDLE_STATUS;
//#include "arduino_secrets.h"

struct can_frame canMsg; // Can message structure for using all CAN functionalities
MCP2515 mcp2515(8);                 // SPI CS Pin 10

// byte mac[] = {0xB8, 0xCA, 0x3A, 0x8B, 0x3B, 0xC6}; //mac adress of output device
byte mac[] = {0xF3, 0xD6, 0xAF, 0xFA, 0xBE, 0x86}; //mac adress of output device
IPAddress ip(20,81,190,176); //ip adress of output device
IPAddress ipInt(192,168,88,205); //ip adress of output device
unsigned int localPort = 8888;      // local port to listen on

char packetBuffer[UDP_TX_PACKET_MAX_SIZE];  // buffer to hold incoming packet,

//NTP stuff - Start
//char ssid[] = WIFI_SSID       //enter network SSID (name)
//char pass[] = WIFI_Pass       //enter network password
int keyIndex = 0;             //enter network key index (only needed for WEP)

unsigned int localPort2 = 2390;                //Local  port to listen for UDP packets 
IPAddress timeServer(129, 6, 15,  28);         //time.nist.gov NTP server     
const int NTP_PACKET_SIZE = 48;               //NTP time stamp is in the first 48 bytes of the message
byte packerBuffer[ NTP_PACKET_SIZE];          //buffer to hold incoming and outoing packets
//NTP stuff - End
unsigned long timeSinceStart;                 //int for the time since arduino started
EthernetUDP Udp; //DecleareEthernet udp structure for udp/ethernet functionalities
//WiFiUDP Udp;     

void setup() {
 while (!Serial);
  Serial.begin(115200);       //begin Serial Monitor at baud rate of 115200
  Serial.println("Pre Bootup");
  Ethernet.init(10);  // tie ethernet to pin 10 !!!! Must change interfears witjh MCP board (This shpuld be moved into udpInitalize() once resolved)
  // Ethernet.begin(mac);
  Serial.println("After Ethernet Begin");
  canInitialize(); //intialize mcp 2515 and CAN bus
  udpInitialize(); // Initialize udp and ethernet functionalities
  timeSinceStart = millis();
  Serial.println("Bootup");
}
void loop() {
  String tempCANstr = canRead(true); //put CAN message into String to then be given to UDP
  if(tempCANstr!= "?"){ //checking if output str is a valid CAN message format
    //Send UDP Packet
    // Serial.println("BEfore UDP");
    udpSend(tempCANstr); //send CAN messageon UDP
     Serial.println("In IF");
  }
  // Serial.println("In Loop");
 
 //NTP stuff - Start
 
 //NEED TO DECLARE timeserver
 sendNTPpacket(timeserver);
 delay(1000);  //waititng to see if reply is available
 if (Udp.parsePacket()){
    Udp.read(packetBuffer, NTP_PACKET_SIZE);        //read the packet into the buffer
    
    //the timestamp starts at byte 40 of the received packet and is four bytes
    unsigned long highWord = word(packetBuffer[40], packetBuffer[41]);
    unsigned long lowWord = word(packetBuffer[42], packetBuffer[43]);
    //combine the two words into a long integer
    unsigned long secsSince1900 = highWord << 16 | lowWord;
    //now comvert NTP to everyday time
    const unsigned long seventyYears = 2208988800UL;  //Unix time starts on Jan 1 1970. In seconds, that's 2208988800
    unsigned long epoch = secsSince1900 - seventyYears;
    //start here once you come back
    // Questions: 
    //Should we convert one of the times into the other's unit (should we convert epoch(seconds) in to milliseconds to add to the start time or vice-versa?)
    

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
  Ethernet.begin(mac, ip); //begin ethernet with mac adress input above setup

  if (Ethernet.linkStatus() == LinkOFF) { //check if ethernet cable is fully connected and able to send data
    Serial.println("Ethernet cable is not connected.");
  }
  Serial.println("UDP Init Done");
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

      //testing
      // Serial.print(canMsg.data[i]);
      // Serial.print("  ");
    }
    //testing
    // Serial.println();

    return str;
  }
  return "?";

}
//Send UDP packet with values put into canM
void udpSend(String canM){
  Udp.beginPacket("litelserver.eastus2.cloudapp.azure.com", 20001); //prepare to send packet in form of EthernetUDP.beginPacket(remoteIP, remotePort);
  // Udp.beginPacket(ip, 20001); //prepare to send packet in form of EthernetUDP.beginPacket(remoteIP, remotePort);
  // Udp.beginPacket(ip, 20001); //prepare to send packet in form of EthernetUDP.beginPacket(remoteIP, remotePort);
  char Buf[canM.length()]; //create char array with length of CAN message
  canM.toCharArray(Buf,canM.length()); //convert can Message string into char array
  Udp.write(Buf); //output char array to UDP
  Udp.endPacket(); //end the packet
}
