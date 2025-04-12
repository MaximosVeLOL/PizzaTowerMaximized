draw_set_color(c_black);
draw_rectangle(-1,-1,961,541, false);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_text(480, 100, screens[currentScreen].title);
draw_sprite(spr_player_idle, -1, 480 - (string_length(screens[currentScreen].optionText[currentOption]) * 12), (200 + (currentOption * 32)))
for(var i = 0 ; i < array_length(screens[currentScreen].optionText);i++) {
	draw_text(480, 200 + (i * 32), string_upper(screens[currentScreen].optionText[i]));
	if(screens[currentScreen].optionTypes != undefined) {
		var t = screens[currentScreen].optionTypes[currentOption];
		if(t == 1) {
			draw_rectangle(480 + (string_length(screens[currentScreen].optionText[currentOption] * 12)) , (i*20) - 20, 10, 10, false);
		}
	}
}