var type = async_load[? "type"];



switch(type) {
	case network_type_connect:
		show_message_async("Client is trying to connect!");
		Log("Got connection!");
		var socket = async_load[? "socket"];
		array_push(clients, new Client(socket));
		//Send id for confirmation
		//packet.EasySend(clients[getLastClient()].socket, DataFlag.RecieveID, getLastClient());
		alarm[0] = 60; // One second
		Log("New client! (size: " + string(array_length(clients)) + ")");
		array_push(players, instance_create_layer(1000, 200, "Instances", Net_o_Player));
	break;
	
	case network_type_disconnect:
		show_message_async("Got disconnected!");
	break;
	
	case network_type_data:
		var buffer = async_load[? "buffer"];
		if(buffer_get_size(buffer) > 32) return;
		buffer_seek(buffer, buffer_seek_start, 0); //Just incase
		var dataType = buffer_read(buffer, buffer_u8);
		var clientID = buffer_read(buffer, buffer_u8);
		
		//Log("Client ID: " + string(clientID));
		if(clientID > getLastClient()) return;
		switch(dataType) {
			
			//Confirmation that everything is good
			case DataFlag.RecieveID:
				//showBuffer(buffer);
				if(clients[clientID].valid) {
					throw("Client " + string(clientID) + " is already vaild!");	
				}
				clients[clientID].valid = true;
				Log("Client " + string(clientID) + " is valid!");
			
			break;
			
			case DataFlag.PlayerData:
				//showBuffer(buffer);
				ReadPlayerPacket(players[clientID]);
			break;
			
			case DataFlag.Disconnect:
				show_message_async("Client " + string(clientID) + " is trying to quit!");
				packet.Reset(0x00);
				packet.Write(buffer_u8, DataFlag.Disconnect);
				packet.Send(clients[clientID].socket);
				for(var i = clientID ; i < array_length(clients) - 1;i++) {
					clients[i] = clients[i + 1];
					packet.Reset(0x00);
					packet.Write(buffer_u8, DataFlag.ClientChange);
					packet.Write(buffer_u8, clientID); //The dead client
					packet.Write(buffer_u8, i); //New ID
					packet.Send(clients[i].socket);
				}
				array_resize(clients, array_length(clients) - 1);
				Log("Array length changed! (" + string(array_length(clients)) + ")");
				instance_destroy(players[clientID]);
			break;
		}
		buffer_delete(buffer);
	break;
}