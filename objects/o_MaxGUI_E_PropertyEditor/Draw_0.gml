if(!o_MaxGUI_Handler.active || !visible) return;
draw_self();

var KEY_WIDTH = 100; //The name
var KEY_HEIGHT = 25; //Height for all
var PROPERTY_WIDTH = 100; //The value

if(mouse_check_button_pressed(mb_right) && inBounds) instance_destroy();

draw_set_color(c_white);
var ignore = false;
draw_set_valign(fa_center);
var blend = c_white;
for(var i = 0 ; i < array_length(targetObject.settings);i++) {
	var cur = targetObject.settings[i];
	var text_length = string_length(cur.name) * 8 + 20;
	//text_length = KEY_WIDTH;
	//var value_length = string_length(string(variable_struct_get(struct, names[i]))) * 12 + 20;
	var value_length = string_width(string(cur.value));
	if(mouse_x >=x && mouse_x <=x + text_length + value_length && mouse_y >= y + (i * KEY_HEIGHT) && mouse_y <= y + ((i+1) * KEY_HEIGHT)) {
		blend = c_gray;
		if(mouse_check_button_pressed(mb_left)) {
			targetValue = i;
			switch(cur.type) {
				case VariableType.Real:
					MaxGUI_CreatePrompt(480, 270, 14, 9, "Type in a (real) value!", function(readString){o_MaxGUI_E_PropertyEditor.targetObject.settings[o_MaxGUI_E_PropertyEditor.targetValue].value = real(readString);});
				break;
					
				case VariableType.Boolean:
					targetObject.settings[i].value = !targetObject.settings[i].value;
				break;
				
				case VariableType.AssetRoom:
					var list = [];
					for(var j = 0 ; j < array_length(o_LevelEditor.rooms);j++) {
						array_push(list, "Room " + string(j));
					}
					MaxGUI_ShowAssetPicker(list, function(i, pList) {
						o_MaxGUI_E_PropertyEditor.targetObject.settings[o_MaxGUI_E_PropertyEditor.targetValue].value = o_LevelEditor.rooms[i];
						o_MaxGUI_E_PropertyEditor.targetObject.settings[o_MaxGUI_E_PropertyEditor.targetValue].renderValue = pList[i];
						MaxGUI_FindElement("AssetPickerGroup").Destroy();
					});
				break;
				
				case VariableType.ObjectVector:
					MaxGUI_CreatePrompt(480, 270, 14, 9, function(readString){
						var text = readString;
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
							var v =  new Vector(width, height);
							o_MaxGUI_E_PropertyEditor.targetObject.settings[o_MaxGUI_E_PropertyEditor.targetValue].value = v;
							o_MaxGUI_E_PropertyEditor.targetObject.settings[o_MaxGUI_E_PropertyEditor.targetValue].renderValue = string(v.x) + " " string(v.y);
							return true;
						}
						catch(e) {
							return false;
						}
					}, "Type in the x and y seperated by spaces!");


				break;
				
				case VariableType.AssetAudio:
					var assets = [
						"music_mainmenu",
						"music_demoroom",
						"music_pizza",
						"music_pizzatime",
						"music_onepizzaatatime",
						"music_water",
						"music_editor",
						"music_secret",
						"music_knight",
					];
					MaxGUI_ShowAssetPicker(assets, function(i, pList) {
						o_MaxGUI_E_PropertyEditor.targetObject.settings[o_MaxGUI_E_PropertyEditor.targetValue].value = asset_get_index(pList[i]);
						o_MaxGUI_E_PropertyEditor.targetObject.settings[o_MaxGUI_E_PropertyEditor.targetValue].renderValue = pList[i];
						MaxGUI_FindElement("AssetPickerGroup").Destroy();
					});
				break;
				
				case VariableType.Array:
					MaxGUI_CreatePrompt(480, 270, 14, 9, function(readString){
						LogError("Placeholder!");
					}, "Type in an array seperated by \"$\"! ");
				break;
			}
		}
	}
	else blend = c_white;

	draw_sprite_stretched_ext(sprite_index, image_index, x , y + (i * KEY_HEIGHT), KEY_WIDTH + value_length, KEY_HEIGHT, blend, 1);
	draw_text(x , y + ( (i * KEY_HEIGHT) + (KEY_HEIGHT / 2) ), cur.name);
	var valX = x + text_length + 10;
	var valY = y + ( (i * KEY_HEIGHT) + (KEY_HEIGHT / 2) );
	switch(cur.type) {
		case VariableType.Boolean:
			draw_set_color(c_black);
			draw_roundrect(valX, valY, valX + 10, valY + 10, false);
			draw_set_color((targetObject.settings[i].value ? c_green : c_red));
			draw_roundrect(valX, valY, valX + 10, valY + 10, false);
		break;
		
		default:
			draw_text(valX, valY, targetObject.settings[i].renderValue);
		break;
	}
	/*
	if(typeof(value) != "struct")
	
	draw_text(x  + text_length + 10, y + ( (i * KEY_HEIGHT) + (KEY_HEIGHT / 2) ), string(value));
	else {
		renderStruct(value, x  + KEY_WIDTH + KEY_HEIGHT + 200, y);
	}
	*/

		
	draw_line(x  + text_length, y + (i * KEY_HEIGHT),x + text_length, y + ((i+1) * KEY_HEIGHT));



}

