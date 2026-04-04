#macro PORT 6741
#macro TYPE network_socket_tcp
#macro IP "127.0.0.1"
#macro MAX_CLIENTS 10
#macro NULL -1
enum DataFlag {
	RecieveID = 0,
	GameData = 1,
	Disconnect = 2,
	ClientChange = 3,
}

global.output = [];
function print(_message) {
	if(array_length(global.output) > 0 && _message == global.output[array_length(global.output) - 1]) return;
	if(array_length(global.output) > 50) array_resize(global.output, 0);
	Log(_message);
	//show_debug_message(_message);
	array_push(global.output, _message);

}
function printCheck() {
	if(keyboard_check_pressed(vk_f5)) {
		var out = "";
		for(var i = 0 ; i < array_length(global.output);i++) {
			out += (global.output[i]) + "\n";
		}
		show_message(out);
	}
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