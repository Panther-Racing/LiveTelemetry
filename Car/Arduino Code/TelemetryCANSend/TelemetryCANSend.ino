/*
TelemtryCANSend

This program reads the CAN bus and sends the data over UDP to a server to be processed
 */

#include <SPI.h>
#include <Ethernet.h>
#include <EthernetUdp.h>

// Enter a MAC address and IP address for your controller below.
// The IP address will be dependent on your local network:
/*byte mac[] = {
  0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED
};*/

//counter for active data transfer
int counter=0;

byte mac[] = {
  0xB8, 0xCA, 0x3A, 0x8B, 0x3B, 0xC6
};
IPAddress ip(192, 168, 1, 177);

unsigned int localPort = 8888;      // local port to listen on

// buffers for receiving and sending data
char packetBuffer[UDP_TX_PACKET_MAX_SIZE];  // buffer to hold incoming packet,
char ReplyBuffer[] = "acknowledged";        // a string to send back

// An EthernetUDP instance to let us send and receive packets over UDP
EthernetUDP Udp;

void setup() {
  // You can use Ethernet.init(pin) to configure the CS pin
  Ethernet.init(10);  // Most Arduino shields
  //Ethernet.init(5);   // MKR ETH shield
  //Ethernet.init(0);   // Teensy 2.0
  //Ethernet.init(20);  // Teensy++ 2.0
  //Ethernet.init(15);  // ESP8266 with Adafruit Featherwing Ethernet
  //Ethernet.init(33);  // ESP32 with Adafruit Featherwing Ethernet

  // start the Ethernet
  Ethernet.begin(mac);

  // Open serial communications and wait for port to open:
  Serial.begin(9600);
  if (Ethernet.linkStatus() == LinkOFF) {
    Serial.println("Ethernet cable is not connected.");
  }

  //startup sequence 
  Serial.println("Before UDP Begin");
  // start UDP
  Udp.begin(localPort);
  Serial.println("After UDP Begin");
  //Udp.endPacket();
}

void loop() {
  //Serial.println("Beginning of Loop");
  // send a reply to the IP address and port that sent us the packet we received
  Udp.beginPacket("raheelfarouk.tplinkdns.com", 20001);
  //Serial.println("After Begin Packet");
  Udp.write("TEST");
  //Serial.println("After Write");
  Serial.println(Udp.endPacket());

  Udp.beginPacket("raheelfarouk.tplinkdns.com", 20001);
  //Serial.println("After Begin Packet");
  String count = "Counter:"+String(counter);
  char Buf[50];
  count.toCharArray(Buf, 50);
  Udp.write(Buf);
  //Serial.println("After Write");
  Udp.endPacket();
  
  Serial.println("Packets Sent. Counter:" + String(counter));

  //incremnet or set counter to 0
  if (counter >=15){
    counter = 0;
  }else{
    counter++;
  }

  Serial.println("Before Delay");
  delay(1000);
}


/*
  Processing sketch to run with this example
 =====================================================

 // Processing UDP example to send and receive string data from Arduino
 // press any key to send the "Hello Arduino" message


 import hypermedia.net.*;

 UDP udp;  // define the UDP object


 void setup() {
 udp = new UDP( this, 6000 );  // create a new datagram connection on port 6000
 //udp.log( true );    // <-- printout the connection activity
 udp.listen( true );           // and wait for incoming message
 }

 void draw()
 {
 }

 void keyPressed() {
 String ip       = "192.168.1.177"; // the remote IP address
 int port        = 8888;    // the destination port

 udp.send("Hello World", ip, port );   // the message to send

 }

 void receive( byte[] data ) {      // <-- default handler
 //void receive( byte[] data, String ip, int port ) { // <-- extended handler

 for(int i=0; i < data.length; i++)
 print(char(data[i]));
 println();
 }
 */
