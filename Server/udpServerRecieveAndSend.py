#!/usr/bin/env python

import socket
import selectors

#Create a selector for handling multiple clients
sel = selectors.DefaultSelector()


#Change to local IP of server -Future version get this automatically
localIP     = "192.168.0.150"
#Car UDP Port
carPort   = 20001
#Client UDP Port
clientPort = 20002
#UDP Buffer size maybe? Need to check CHK
bufferSize  = 1024

 
#Message to send to deivce, maybe a pairing message to recieve car number? FUT
msgFromServer       = "Hello UDP Client"
bytesToSend         = str.encode(msgFromServer)

 

# Create two datagram sockets, one for car and one for clients
UDPCarSocket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)
UDPClientSocket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)

 

# Bind both sockets to address and ip
UDPCarSocket.bind((localIP, carPort))
UDPClientSocket.bind((localIP, clientPort))

print("UDP server up and listening")

 

# Listen for incoming datagrams
while(True):

    #Listen for incoming requests to be a client
    clientRequestPackage = UDPClientSocket.recvfrom(bufferSize)
    # Get address of client
    clientAddress = clientRequestPackage[1]
    #Get message from client -- Not really needed
    clientMsg = clientRequestPackage[0]

    #Listen for incoming data from the car
    carDataPackage = UDPCarSocket.recvfrom(bufferSize)
    #Get address of car -- Not really needed
    carAddress = carDataPackage[1]
    #Extract Message from the car
    carMsg = carDataPackage[0]

    
    print("Message from Client:{}".format(clientMsg))
    print("Client IP Address:{}".format(clientAddress))
    print("Car Data:{}".format(carMsg))
    print("Car IP Address:{}".format(carAddress))

   
    #Add newline to end of car data
    carMsg += "\n"

    #Encode the car data
    bytesToSend = str.encode(carMsg)

    # Sending data to client
    UDPClientSocket.sendto(bytesToSend, clientAddress)