if(!o_MaxGUI_Handler.active) return;

var xCheck = mouse_x >= x && mouse_x <= x + sprite_width; //We don't need to repeat this for i times.
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
for(var i = 0 ; i < array_length(list);i++) {
	
	
	if(xCheck && mouse_y >= bbox_top + (elementHeight * i) && mouse_y <= bbox_top + (elementHeight * (i + 1) ) ) {
		image_index = 1;
		if(mouse_check_button_pressed(mb_left)) {
			currentListIndex = i;
			onSwitch();
			
		}
	}
	else image_index = 0;
	draw_sprite_stretched(sprite_index, image_index, x,y + (elementHeight * i), sprite_width, elementHeight);
	draw_text(x + (sprite_width / 2), y + ((elementHeight * (i+1)) - (elementHeight / 2)), string(list[i]));
}

GUI_RESET;