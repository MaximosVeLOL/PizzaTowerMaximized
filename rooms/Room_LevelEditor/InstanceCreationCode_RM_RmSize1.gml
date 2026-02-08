onClick = function() {
	CreatePrompt(680, 270, 14, 9, function(text){
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
}