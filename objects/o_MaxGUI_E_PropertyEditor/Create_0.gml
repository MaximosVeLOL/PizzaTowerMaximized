event_inherited();
doHighlight = false;
temporaryBuffer = [];
targetValue = "";
image_xscale = 10;
image_yscale = 5;

renderStruct = function(struct, atX, atY) {
//Render property
	var KEY_WIDTH = 100; //The name
	var KEY_HEIGHT = 25; //Height for all
	var PROPERTY_WIDTH = 100; //The value

	if(mouse_check_button_pressed(mb_right) && inBounds) instance_destroy();

	draw_set_color(c_white);

	var names = variable_struct_get_names(targetObject);
	show_debug_message(names);
	var ignore = false;
	draw_set_valign(fa_center);
	var blend = c_white;
	for(var i = 0 ; i < array_length(names);i++) {
		var text_length = string_length(names[i]) * 8 + 20;
		//text_length = KEY_WIDTH;
		var value_length = string_length(string(variable_struct_get(struct, names[i]))) * 12 + 20;
		if(mouse_x >=atX&& mouse_x <=atX+ text_length + value_length && mouse_y >= atY + (i * KEY_HEIGHT) && mouse_y <= atY + ((i+1) * KEY_HEIGHT)) {
			blend = c_gray;
			targetValue = names[i];
			if(mouse_check_button_pressed(mb_left)) {
				CreatePrompt(200, 200, 10, 5, function(val) {
					var realValue = 0;
					var type = typeof(variable_struct_get(o_MaxGUI_E_PropertyEditor.struct, o_MaxGUI_E_PropertyEditor.targetValue));
					try {
						if(type == "number") {
							realValue = real(val);
						}
						else if(type == "string") {
							realValue = val;
						}
						else if(type == "bool") {
							realValue = bool(val);
						}
					}
					catch(e) {
						return;
					}
				
					variable_struct_set(o_MaxGUI_E_PropertyEditor.struct, o_MaxGUI_E_PropertyEditor.targetValue, realValue);
				}, "Enter value");
			}
		}
		else blend = c_white;

		draw_sprite_stretched_ext(sprite_index, image_index, atX, atY + (i * KEY_HEIGHT), KEY_WIDTH + value_length, KEY_HEIGHT, blend, 1);
		draw_text(atX, atY + ( (i * KEY_HEIGHT) + (KEY_HEIGHT / 2) ), names[i]);
		var value = variable_struct_get(struct, names[i]);
		if(typeof(value) != "struct")
			draw_text(atX + text_length + 10, atY + ( (i * KEY_HEIGHT) + (KEY_HEIGHT / 2) ), string(value));
		else {
			renderStruct(value, atX + KEY_WIDTH + KEY_HEIGHT + 200, atY);
		}

		
		draw_line(atX + text_length, atY + (i * KEY_HEIGHT),atX+ text_length, atY + ((i+1) * KEY_HEIGHT));



	}
}