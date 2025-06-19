if(active) {
	draw_set_font(-1);
	draw_set_color(c_black);
	draw_rectangle(0,0, 960, 100, false);
	draw_set_color(c_white);
	for(var i = 0 ; i < array_length(prevCommands);i++) {
		draw_set_alpha(0.5);
		draw_text(10, 60 - (i * 20), prevCommands[(array_length(prevCommands) - 1) - i]);
		draw_set_alpha(1);
	}
	var i = [];
	for(var c = 0; c < array_length(commands);c++) {
		if(string_count(keyboard_string, commands[c].name) > 0) {
			array_resize(i, array_length(i) + 1);
			i[array_length(i) - 1] = c;
		}
	}
	draw_set_color(c_black);
	for(var j = 0; j < array_length(i);j++) {
		draw_rectangle(0, 100+(j*20), string_length(commands[i[j]].name) * 12, 140 + (j * 20), false );
	}
	draw_set_color(c_white);
	for(var j = 0; j < array_length(i);j++) {
		draw_text(10,110+(j*20), commands[i[j]].name);
	}
	draw_text(10,80, keyboard_string);
	GUI_RESET;
}