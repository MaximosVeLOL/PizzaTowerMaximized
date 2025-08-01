event_inherited();
serverSettings = {
	maxPlayers : 10,
	port : 65535,
	socketType : network_socket_tcp,
};


networkSettings = {
	socket : network_create_socket(serverSettings.socketType),
	buffer : buffer_create(1024, buffer_fixed, 1),
};
var value = network_connect(networkSettings.socket, "167.89.244.246", serverSettings.port);
//var helloBuffer = buffer_create(buffer_sizeof(buffer_u8), buffer_fixed, 1);
//buffer_write(helloBuffer, buffer_u8, 0xFF);
//network_send_packet(networkSettings.socket, helloBuffer, buffer_sizeof(buffer_u8) );
if(value < 0) throw("Failed to connect to network.");
show_message(value);