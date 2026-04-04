/*
	Host server
	Host clients
	Get packets from client
	Send packets to clients
*/
server = NULL;
packet = new Packet();
clients = [];

destroy = function() {
	packet.Reset(0x00);
	packet.Write(buffer_u8, DataFlag.Disconnect);
	sendPacketsToAllClients();
}

setupServer = function(maxClients) {
	server = network_create_server(TYPE, PORT, maxClients);
	if(server >= 0) return true;
	else return false;
}

getLastClient = function() {
	return array_length(clients) - 1;
}

sendPacket = function(clientID) {
	buffer_seek(packet, buffer_seek_start, 0);
	for(var i = 1 ; i < argument_count;i++) {
		buffer_write(packet, buffer_u8, argument[i]);
	}
	network_send_packet(clients[clientID].socket, packet, 32);
}

sendPacketsToAllClients = function(exclusion = -1) {
	for(var i = 0 ; i < array_length(clients);i++) {
		if(i == exclusion) continue;
		packet.Send(clients[i].socket);
	}
}
//show_message("I exist!");


players = [];