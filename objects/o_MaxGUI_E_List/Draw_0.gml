if(!o_GUIHandler.active) return;
var height = sprite_height / array_length(list); //We don't need to repeat this for i times.
var xCheck = mouse_x >= bbox_left && mouse_x <= bbox_right; //We don't need to repeat this for i times.
for(var i = 0 ; i < array_length(list);i++) {
	
	
	if(xCheck && mouse_y >= bbox_top + (height * i) && mouse_y <= bbox_top + (height * (i + 1) ) ) {
		image_index = 1;
		if(mouse_check_button_pressed(mb_left)) {
			currentListIndex = i;
			onSwitch();
			
		}
	}
	else image_index = 0;
	draw_sprite_stretched(sprite_index, image_index, x,y + (height * i), sprite_width, height);
	draw_text(x + (sprite_width / 2), y + ( (height / 2) + height * i), string(list[i]));
}

GUI_RESET;