import socket
import time

serverPort = 20001

# Get the current computer's Address and the server's Address
myAddress = input("Enter the IP Address of this computer: ")
# myAddress = socket.gethostbyname(socket.gethostname())
#serverAddress = (input("Enter the IP Address of the server: "), 20001)
# ip = socket.gethostbyname('litelserver.eastus.cloudapp.azure.com')
ip = '20.81.190.176'
# ip = socket.gethostbyname('litelserver.eastus2.cloudapp.azure.com')
serverAddress = (ip, 20001)
# serverAddress = ("litelserver.eastus.cloudapp.azure.com", 20001)

# Create and bind the socket
serverSocket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)
serverSocket.bind((myAddress, serverPort))

while True:

    line = '8, 640,00 00 03 d0 01 40 00 ad'
    bytesToSend = str.encode(line)
    serverSocket.sendto(bytesToSend, serverAddress)
    time.sleep(.1)

