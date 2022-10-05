udpSocket = udpport("byte", "IPV4");

% write to UDP Server
write(udpSocket, "I want data", "string", "raheelfarouk.tplinkdns.com", 20001);

udpData = read(udpSocket, 100, "string")
