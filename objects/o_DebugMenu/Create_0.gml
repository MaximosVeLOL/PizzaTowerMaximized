roomStuff = {
	roomTextInput : "",
	
}

dbg_view("Room Stuff", false, 960/2, 540/2, 300, 300);


dbg_text_input(ref_create(roomStuff, "roomTextInput"), "Req Room Name", "s");