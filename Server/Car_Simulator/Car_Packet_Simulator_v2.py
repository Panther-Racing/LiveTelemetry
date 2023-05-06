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
    # Open the sample data file
    f = open('CarData.txt', 'r')
    data = []
    # Read in the first line of data
    line = f.readline()

    # While there is valid data to read in, continue reading it into an array
    while line:
        line = line.replace('\n', '')
        print(line)
        bytesToSend = str.encode(line)
        serverSocket.sendto(bytesToSend, serverAddress)
        line = f.readline()
        time.sleep(.1)

    f.close()
