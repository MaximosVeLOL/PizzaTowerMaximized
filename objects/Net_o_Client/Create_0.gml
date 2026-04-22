socket = NULL;
packet = new Packet();
hasConnection = true;
waitingForDisconnect = false;
ID = 230;
waitingForConnect = false;
connectTime = 0;

tryConnect = function(ip) {
	socket = network_create_socket(TYPE);
	waitingForConnect = true;
	var connection = network_connect_async(socket, ip, PORT);
}

startDisconnect = function() {
	waitingForDisconnect = true;
	packet.Reset(0x00);
	packet.Write(buffer_u8, DataFlag.Disconnect);
	packet.Send(socket);
}

doDisconnect = function() {
	if(!waitingForDisconnect) return;
	print("Disconnecting from server.settings..");
	network_destroy(socket);
	socket = NULL;
	hasConnection = false;
	o_GameManager.returnToMenu();
}

players = [];