if(array_length(clients) > 1) {
	for(var source = 0; source < array_length(clients);source++) {
		if(!clients[source].valid) continue;
		//packet.Reset();
		CreatePlayerPacket(source, players[source].x, players[source].y, players[source].sprite_index, players[source].image_index, players[source].image_xscale, players[source].roomIn);
		/*
		packet.Write(buffer_u8, DataFlag.PlayerData);
		packet.Write(buffer_u8, source);
		packet.Write(buffer_u16, players[source].x);
		packet.Write(buffer_u16, players[source].y);
		packet.Write(buffer_u32, players[source].sprite_index);
		packet.Write(buffer_u8, players[source].image_index);
		packet.Write(buffer_s8, players[source].image_xscale);
		packet.Write(buffer_u32, players[source].roomIn);
		*/
		for(var output = 0; output < array_length(clients);output++) {
			if(!clients[output].valid || output == source) continue;
			//Log("Sending client " + string(source) + "'s packet to client " + string(output) + "!"); 
			packet.Send(clients[output].socket);
		}
	}
}
if(keyboard_check_pressed(ord("~")) || keyboard_check_pressed(ord("`"))) {
	displayMenu = !displayMenu;
	instance_deactivate_all(true);
}
if(displayMenu) {
	menuY += (GetInput("up") - GetInput("down"));
}