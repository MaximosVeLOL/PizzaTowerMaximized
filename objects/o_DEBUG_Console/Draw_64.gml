if(active) {
	draw_set_font(-1);
	draw_set_color(c_black);
	draw_rectangle(0,0, 960, 100, false);
	draw_set_color(c_white);
	var i = 0; //Remember kids, always make good use of your variables!
	draw_set_alpha(0.5); //Why was this also in the for loop?
	for(i = 0 ; i < array_length(prevCommands);i++) {
		if(60 - (i * 20) < 0) break; //Don't waste time rendering out of the screen
		draw_text(10, 60 - (i * 20), prevCommands[(array_length(prevCommands) - 1) - i]);
	}
	draw_set_alpha(1); //Why was this in the for loop???
	/*
	//Hoo boy! We went from 3 for loops (2 for visuals), to just one for loop...
	var yPos = 0;
	for(i = 0 ; i < array_length(commands);i++) {
		if(string_count(keyboard_string, commands[i].name) > 0) {
			draw_set_color(c_black);
			draw_rectangle(0, 100 + yPos, string_width(commands[i].name) + 12, 100 + string_height(commands[i].name), false);
			draw_set_color(c_white);
			draw_text(10, 110 + yPos, commands[i].name);
			yPos += string_height(commands[i].name);
			draw_line(0, 100 + yPos, string_width(commands[i].name), 100 + (yPos+20));
		}
	} 
	/*
	var i = [];
	for(var c = 0; c < array_length(commands);c++) { Get commands
		if(string_count(keyboard_string, commands[c].name) > 0) {
			array_resize(i, array_length(i) + 1);
			i[array_length(i) - 1] = c;
		}
	}
	draw_set_color(c_black);
	for(var j = 0; j < array_length(i);j++) { Render rectangles
		draw_rectangle(0, 100+(j*20), string_length(commands[i[j]].name) * 12, 140 + (j * 20), false );
	}
	draw_set_color(c_white);
	for(var j = 0; j < array_length(i);j++) { //Render text
		draw_text(10,110+(j*20), commands[i[j]].name);
	}
	*/
	draw_text(10,80, keyboard_string);
	GUI_RESET;
}