<<<<<<< HEAD
%--------------------------------------------------------------------------------------
%Setup Virtual CAN Adapter here
%--------------------------------------------------------------------------------------
=======
clear
clc

>>>>>>> 5afd4533fbc2d8a510a0276920bc28c9029d2641
%create Virtual CAN Bus channel
can1 = canChannel('MathWorks', 'Virtual 1', 1);

%Configure the bus speed for the virtual CAN Bus
<<<<<<< HEAD
configBusSpeed(can1,1000000);

%Set the CAN Channel online
start(can1)
%--------------------------------------------------------------------------------------

%--------------------------------------------------------------------------------------
%Setup the UDP Communication here
%--------------------------------------------------------------------------------------
=======
configBusSpeed(can1,1000000)

%This is the message object we are sending to the CAN Bus -- canMessage(CAN ID, Extended, Datalength)
messageout = canMessage(500,false,8)

>>>>>>> 5afd4533fbc2d8a510a0276920bc28c9029d2641
%UDP Socket object
udpSocket1 = udpport("byte", "IPV4");
    
%udpSocket2 = udpport("byte", "IPV4");
%client = tcpclient("raheelfarouk.tplinkdns.com",20003)
<<<<<<< HEAD

serverAddress = "raheelfarouk.tplinkdns.com";

% write to UDP Server
write(udpSocket1, "Add Me", "string", serverAddress, 20003);
%write(client,"Add Me")
%--------------------------------------------------------------------------------------

%--------------------------------------------------------------------------------------
%Read data from UDP Server
%--------------------------------------------------------------------------------------
=======
    
% write to UDP Server
write(udpSocket1, "Add Me", "string", "raheelfarouk.tplinkdns.com", 20003);
%write(client,"Add Me")

%Set the CAN Channel online
start(can1)

>>>>>>> 5afd4533fbc2d8a510a0276920bc28c9029d2641
while true
    %Read data from UDP Server
    udpData = readline(udpSocket1)

<<<<<<< HEAD
    %We need to decode the UDP Packet here

    %This is the message object we are sending to the CAN Bus -- canMessage(CAN ID, Extended, Datalength)
    messageout = canMessage(500,false,8);

    %This makes the message to send --
    %pack(message,value,startbit,signalsize,byteorder) 
    pack(messageout,udpData,0,8,'BigEndian')
=======
    %This makes the message to send --
    %pack(message,value,startbit,signalsize,byteorder) 
    pack(messageout,25,0,8,udpData)
>>>>>>> 5afd4533fbc2d8a510a0276920bc28c9029d2641
    
    %Send the message, messageout has the data to send
    transmit(can1,messageout)
end
%--------------------------------------------------------------------------------------
