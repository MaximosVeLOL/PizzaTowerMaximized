if(!hasConnection || ID == 230) return;

CreatePlayerPacket(packet);
packet.Send(socket);

if(keyboard_check_pressed(ord("C"))) {
	typingMessage = !typingMessage;
	keyboard_string = "";
	o_GameManager.mode = (typingMessage ? "none" : "game");

}
if(typingMessage) {
	if(keyboard_check_pressed(vk_enter)) {
		packet.Reset();
		//packet.Write(buffer_string, keyboard_string);
		packet.Write(buffer_u8, DataFlag.MessageData);
		packet.Write(buffer_u8, ID);
		//Safer?
		for(var i = 0 ; i < string_length(keyboard_string);i++) {
			packet.Write(buffer_s8, string_char_at(keyboard_string, i));
		}
		packet.Send(socket);		
		
		typingMessage = false;
		o_GameManager.mode = "game";
		keyboard_string = "";
	}
}