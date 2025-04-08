if(active) {
	o_Camera.hudVisible = !active;
	draw_set_font(-1);
	draw_set_color(c_black);
	draw_rectangle(0,0, 960, 100, false);
	draw_set_color(c_white);
	for(var i = 0 ; i < array_length(commands);i++) {
		draw_text(10, 110 + (i * 20), commands[i].usage );
	}
	draw_text(10,94, currentCommand);
	GUI_RESET;
}