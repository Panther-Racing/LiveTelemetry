clear;

%--------------------------------------------------------------------------------------
%Setup Virtual CAN Adapter here
%--------------------------------------------------------------------------------------
%create Virtual CAN Bus channel
can1 = canChannel('MathWorks', 'Virtual 1', 1);

%Configure the bus speed for the virtual CAN Bus
configBusSpeed(can1,1000000);

%Set the CAN Channel online
start(can1)
%--------------------------------------------------------------------------------------

%--------------------------------------------------------------------------------------
%Setup the UDP Communication here
%--------------------------------------------------------------------------------------
%UDP Socket object
udpSocket1 = udpport("byte", "IPV4");

%udpSocket2 = udpport("byte", "IPV4");
%client = tcpclient("raheelfarouk.tplinkdns.com",20003)

serverAddress = "192.168.1.100";

% write to UDP Server
write(udpSocket1, "Add Me", "string", serverAddress, 20003);
%write(client,"Add Me")
%--------------------------------------------------------------------------------------

%--------------------------------------------------------------------------------------
%Read data from UDP Server
%--------------------------------------------------------------------------------------
while true
    udpData = readline(udpSocket1)

    %We need to decode the UDP Packet here
    canNums = split(udpData, ",")
    canid = str2double(canNums(1))
    canMsgLen = str2double(canNums(2))
    
    messageout = canMessage(canid,false,canMsgLen);

    n = 1;
    x = 3;
    while n < canMsgLen
        canData = str2double(canNums(x))
        pack(messageout,canData,8*(n-1),8,'BigEndian')
        n= n+1;
        x = x+1;
    end
    %This is the message object we are sending to the CAN Bus -- canMessage(CAN ID, Extended, Datalength)
%     messageout = canMessage(500,false,8);

    %This makes the message to send --
    %pack(message,value,startbit,signalsize,byteorder) 
%     pack(messageout,udpData,0,8,'BigEndian')
    
    %Send the message, messageout has the data to send
    transmit(can1,messageout)
end
%--------------------------------------------------------------------------------------
