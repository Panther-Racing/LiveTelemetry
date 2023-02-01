#!/usr/bin/env python

'''
This is for testing the communication to the server

Written By: Raheel Farouk
'''

import socket
import time

 #Message to send from client, this will be from arduino to the Server
msgFromClient       = "Hello UDP Server"

bytesToSend         = str.encode(msgFromClient)

serverAddressPort   = (socket.gethostbyname('raheelfarouk.tplinkdns.com'), 20001)

bufferSize          = 1024

 

# Create a UDP socket at client side

UDPClientSocket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)

 
while True:
    # Send to server using created UDP socket
    UDPClientSocket.sendto(bytesToSend, serverAddressPort)
    time.sleep(0.01)

 

#msgFromServer = UDPClientSocket.recvfrom(bufferSize)

 

#msg = "Message from Server {}".format(msgFromServer[0])

#print(msg)