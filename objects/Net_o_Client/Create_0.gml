
socket = NULL;
packet = new Packet();
hasConnection = true;
waitingForDisconnect = false;
ID = 230;
waitingForConnect = false;
connectTime = 0;

typingMessage = false;

tryConnect = function(ip) {
	//socket = network_create_socket(TYPE);
	socket = network_create_socket_ext(TYPE, PORT);
	if(socket < 0)
		Log("Failed to create socket");
	//waitingForConnect = true;
	Log("Connecting to ip " + ip + "...");
	var connection = network_connect_raw(socket, ip, PORT);
	//var connection = network_connect_async(socket, ip, PORT);
	//Log("Success!");
	return (connection >= 0);
}

startDisconnect = function() {
	waitingForDisconnect = true;
	packet.Reset(0x00);
	packet.Write(buffer_u8, DataFlag.Disconnect);
	packet.Send(socket);
}

doDisconnect = function() {
	if(!waitingForDisconnect) return;
	Log("Disconnecting from server.settings..");
	network_destroy(socket);
	socket = NULL;
	hasConnection = false;
	o_GameManager.returnToMenu();
}

players = [];