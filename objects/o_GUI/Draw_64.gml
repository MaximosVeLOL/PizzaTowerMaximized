var e = getCurrentScreen().elements;
for(var i = 0 ; i < array_length(e);i++) {
	if(!getCurrentScreen().isActive) continue;
	with(e[i]) {
		mousePosition = o_GUI.getMouse();
		mouseCheck = mouse_check_button_released(mb_left);
		inBounds = mousePosition[0] >= transform.x && mousePosition[0] <= transform.x + transform.width && mousePosition[1] >= transform.y && mousePosition[1] <= transform.y + transform.height;
		//if(mouse_check_button_pressed(mb_right) && inBounds) show_message("DEBUG INFORMATION:\n " + string(e[i]));
		if(active) {
			step();
			draw_set_color(c_white);
			draw_set_alpha(1);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
		}
		
	}
};