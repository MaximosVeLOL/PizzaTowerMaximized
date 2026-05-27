#macro PORT 0x7074 //"pt" in hex
#macro TYPE network_socket_udp
#macro IP "127.0.0.1"
#macro MAX_CLIENTS 10
#macro NULL -1
enum DataFlag {
	//When connecting to a server and recieving an ID to know the player
	RecieveID = 0,
	//Player position and visual data
	PlayerData = 1,
	//I want to disconnect!
	Disconnect = 2,
	//A client has changed?
	ClientChange = 3,
	//An object needs to be syncronized on all clients!
	SyncData = 4,
	//Message sent from somebody to everybody
	MessageData = 5,
}

function CreatePlayerPacket(pPacketIn, pID = ID, pX = o_Player.x, pY = o_Player.y, pSpriteIndex = o_Player.sprite_index, pImageIndex = o_Player.image_index, pDirection = o_Player.image_xscale, pRoomIndex = room) {
	pPacketIn.Reset(0x00);
	pPacketIn.Write(buffer_u8, DataFlag.PlayerData);
	pPacketIn.Write(buffer_u8, pID);
	pPacketIn.Write(buffer_u16, pY);
	pPacketIn.Write(buffer_u16, pY);
	pPacketIn.Write(buffer_u32, pSpriteIndex);
	pPacketIn.Write(buffer_u8, pImageIndex);
	pPacketIn.Write(buffer_s8, pDirection);
	pPacketIn.Write(buffer_u32, pRoomIndex);
}
function ReadPlayerPacket(pOutput) {
	/*return {
		x : buffer_read(buffer, buffer_u16),
		y : buffer_read(buffer, buffer_u16),
		sprite_index : buffer_read(buffer, buffer_u32),
		image_index : buffer_read(buffer, buffer_u8),
		image_xscale : buffer_read(buffer, buffer_s8),
		roomIn : buffer_read(buffer, buffer_u32),
	}*/
	pOutput.x = buffer_read(buffer, buffer_u16);
	pOutput.y = buffer_read(buffer, buffer_u16);
	pOutput.sprite_index = buffer_read(buffer, buffer_u32);
	pOutput.image_index = buffer_read(buffer, buffer_u8);
	pOutput.image_xscale = buffer_read(buffer, buffer_s8);
	pOutput.roomIn = buffer_read(buffer, buffer_u32);
}
//Clients for the network
function Client(_socket = NULL) constructor {
	socket = _socket;
	packet = buffer_create(32, buffer_fixed, 1);
	valid = false;
	//hasNewSize = true;
}

function showBuffer(buffer) {
	buffer_seek(buffer, buffer_seek_start, 0);
	var out = "";
	for(var i = 0 ; i < buffer_get_size(buffer);i++) {
		out += string(buffer_read(buffer, buffer_u8)) + "\n";
	}
	show_message(out);
	buffer_seek(buffer, buffer_seek_start, 0);

}
#macro PACKET_LENGTH 32
function Packet() constructor {
	
	data = buffer_create(PACKET_LENGTH, buffer_fixed, 1);
	
	Reset = function() {
		buffer_seek(data, buffer_seek_start, 0);
		/*for(var i = 0 ; i < PACKET_LENGTH / 8;i++) { //4
			buffer_write(data, buffer_u64, 0x255);
		}
		buffer_seek(data, buffer_seek_start, 0);
		*/
	}
	/*
	function Write(dataa, isString = false) {
		var type = buffer_string;
		if(!isString) {
			switch(string_length(data)) {
				case 1:
					type = buffer_u8;
				break;
			
				case 2:
					type = buffer_u16;
				break;
			
				case 4:
					type = buffer_u64;
				break;
			}
		}
		
		buffer_write(data, type, real(dataa));
	}*/
	Write = function(type, dataa) {
		buffer_write(data, type, dataa);
	}
	
	
	Send = function(targetSocket) {
		//buffer_seek(data, buffer_seek_start, 0);
		network_send_packet(targetSocket, data, PACKET_LENGTH);
		Reset(0);
	}
}

function OtherClient(_id = NULL) {
	ID = _id;
}