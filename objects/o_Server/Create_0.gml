settings = {
	maxPlayers : 2,
	port : 27015,
	socketType : network_socket_udp,
}



network_create_server(settings.socketType, settings.port, settings.maxPlayers );
