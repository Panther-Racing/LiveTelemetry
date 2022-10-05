#!/usr/bin/env python

import socket

 
#Change to local IP of server -Future version get this automatically
localIP     = "192.168.0.150"
#local UDP Port
localPort   = 20001
#UDP Buffer size maybe? Need to check CHK
bufferSize  = 1024

 
#Message to send to deivce, maybe a pairing message to recieve car number? FUT
msgFromServer       = "Hello UDP Client"
bytesToSend         = str.encode(msgFromServer)

 

# Create a datagram socket
UDPServerSocket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)

 

# Bind to address and ip
UDPServerSocket.bind((localIP, localPort))

print("UDP server up and listening")

 

# Listen for incoming datagrams
while(True):

    bytesAddressPair = UDPServerSocket.recvfrom(bufferSize)

    #get message from UDP Packet
    message = bytesAddressPair[0]

    #get address from UDP Socket
    address = bytesAddressPair[1]

    clientMsg = "Message from Client:{}".format(message)
    clientIP  = "Client IP Address:{}".format(address)
    
    print(clientMsg)
    print(clientIP)

   

    # Sending a reply to client
    UDPServerSocket.sendto(bytesToSend, address)