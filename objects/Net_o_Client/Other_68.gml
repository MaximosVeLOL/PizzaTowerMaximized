var type = async_load[? "type"];



switch(type) {
	
	case network_type_data:
		var buffer = async_load[? "buffer"];
		buffer_seek(buffer, buffer_seek_start, 0); //Just incase
		var dataType = buffer_read(buffer, buffer_u8);
		if(waitingForConnect) {
			Log("Going to connect to server!");
			hasConnection = true;
			waitingForConnect = false;
			o_GameManager.goToHub();
			o_GameManager.mode = "game";
		}
		
		switch(dataType) {
			case DataFlag.RecieveID:
				var recID = buffer_read(buffer, buffer_u8);
				ID = recID;
				//showBuffer(buffer);
				//show_message("RecID: " + string(ID));
				packet.Reset();
				packet.Write(buffer_u8, DataFlag.RecieveID);
				packet.Write(buffer_u8, recID);
				packet.Send(socket);
				var maxClients = buffer_read(buffer, buffer_u8);
				players = array_create(maxClients, undefined); //Max clients minus 1
				for(var i = 0 ; i < maxClients;i++) {
					players[i] = instance_create_depth(-1000, -1000, 0, Net_o_Player);	
				}
				//packet.EasySend(socket, DataFlag.RecieveID, recID);
			break;
			
			case DataFlag.GameData:
				//0 = Server
				
				var clientID = buffer_read(buffer, buffer_u8);
				print("Got client ID for " + string(clientID));
				//show_message("Got client id! " + string(clientID));
				players[clientID].x = buffer_read(buffer, buffer_u16);
				players[clientID].y = buffer_read(buffer, buffer_u16);
				players[clientID].sprite_index = buffer_read(buffer, buffer_u32);
				players[clientID].image_index = buffer_read(buffer, buffer_u8);
				players[clientID].image_xscale = buffer_read(buffer, buffer_s8);
				players[clientID].roomIn = buffer_read(buffer, buffer_u32);
			break;
			
			case DataFlag.Disconnect:
				if(!waitingForDisconnect) return;
				doDisconnect();
			break;
			
			case DataFlag.ClientChange:
				var deadClient = buffer_read(buffer, buffer_u8);
				print("Client change (ID " + string(ID) + "), for " + string(deadClient));
				tests[deadClient] = new Vector();
				ID = buffer_read(buffer, buffer_u8);
			break;
			
		}
	break;
}