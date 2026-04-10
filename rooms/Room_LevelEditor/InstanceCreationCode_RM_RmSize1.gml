onClick = function() {
	MaxGUI_CreatePrompt(o_LevelEditor.offset[0] + 270, o_LevelEditor.offset[1] + 180, 14, 9, function(text){
		var _temp = "";
		var out = [];
		for(var i = 1 ; i <= string_length(text);i++) {
			_temp += string_char_at(text, i);
			if(string_count(" ", _temp) > 0) {
				//show_message(_temp);
				array_push(out, real(string_copy(_temp, 0, string_length(_temp ) - 1)));
				_temp = "";
			}
			if(i == string_length(text)) array_push(out, real(_temp));
		}
		//show_message(string(out));
		if(out[0] < 960 || out[1] < 540) return false;
		try {
			room_width = out[0];
			room_height = out[1];
		}
		catch(e) {
			return false;
		}
		
		return true;
		
	}, "Set the room size");
	/*
	var text = MaxGUI_FindElement("rE_i").text;
	if(text == "") return false; //No input detected (can be detected by the try catch case)
	var offset = string_pos(" ", text);
	if(offset == 0) return false; //Failed to find
	var width = string_copy(text , 1, offset - 1);
	//Log("Width: " + width);
	var height = string_copy(text, offset + 1, string_length(text) - (offset - 1));
	//Log("Height: " + height);
	
	try {
		width = real(width);
		height = real(height);
		if(width < 960 || height < 540) return false;
		room_width = width;
		room_height = height;
	}
	catch(e) {
		return false;
	}
	*/
	
	
}