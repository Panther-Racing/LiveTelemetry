udpSocket = udpport("byte", "IPV4");
client = tcpclient("raheelfarouk.tplinkdns.com",20003)

% write to UDP Server
%write(udpSocket, "I want data", "string", "raheelfarouk.tplinkdns.com", 20002);
write(client,"Add Me","string")

while true
    udpData = readline(udpSocket)
end
