socket = NULL;
packet = new Packet();
hasConnection = true;
waitingForDisconnect = false;
ID = 230;

tryConnect = function(ip) {
	socket = network_create_socket(TYPE);
	var connection = network_connect(socket, ip, PORT);
	hasConnection = (connection >= 0);
	return hasConnection;
}

startDisconnect = function() {
	waitingForDisconnect = true;
	packet.Reset(0x00);
	packet.Write(buffer_u8, DataFlag.Disconnect);
	packet.Send(socket);
}

doDisconnect = function() {
	if(!waitingForDisconnect) return;
	print("Disconnecting from server...");
	network_destroy(socket);
	socket = NULL;
	hasConnection = false;
}

players = [];