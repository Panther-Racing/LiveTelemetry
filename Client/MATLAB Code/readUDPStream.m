udpSocket = udpport("byte", "IPV4");

% write to UDP Server
write(udpSocket, 1:5, "uint8", "raheelfarouk.tplinkdns.com", 20001);

udpData = read(udpSocket, 4, "string")
