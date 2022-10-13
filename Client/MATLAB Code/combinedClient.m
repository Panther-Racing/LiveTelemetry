clear
clc

%create Virtual CAN Bus channel
can1 = canChannel('MathWorks', 'Virtual 1', 1)

%Configure the bus speed for the virtual CAN Bus
configBusSpeed(can1,1000000)

%This is the message object we are sending to the CAN Bus -- canMessage(CAN ID, Extended, Datalength)
messageout = canMessage(500,false,8)

%UDP Socket object
udpSocket1 = udpport("byte", "IPV4");
    
%udpSocket2 = udpport("byte", "IPV4");
%client = tcpclient("raheelfarouk.tplinkdns.com",20003)
    
% write to UDP Server
write(udpSocket1, "Add Me", "string", "raheelfarouk.tplinkdns.com", 20003);
%write(client,"Add Me")

while true
    %Read data from UDP Server
    udpData = readline(udpSocket1)

    %This makes the message to send --
    %pack(message,value,startbit,signalsize,byteorder) 
    pack(messageout,25,0,8,udpData)
    
    %Set the CAN Channel online
    start(can1)
    
    %Send the message, messageout has the data to send
    transmit(can1,messageout)
end
