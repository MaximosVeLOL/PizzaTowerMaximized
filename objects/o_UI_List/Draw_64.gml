draw_set_font(settings.text.font);



if(settings.background.render) {
	draw_set_color(settings.background.color);
	draw_rectangle(-1,-1,960,540, false);
}
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_text(settings.x, settings.y + 100, screens[currentScreen].title);
var TEXT_X_MULT = 24;
var TEXT_Y_MULT = 48;


draw_sprite(sprite_hud_optionsarrow, -1, settings.x - ((string_length(screens[currentScreen].optionText[currentOption]) * (TEXT_X_MULT/2)) + 55), ((settings.y + 200) + (currentOption * TEXT_Y_MULT)))
for(var i = 0 ; i < array_length(screens[currentScreen].optionText);i++) {
	if(i == currentOption) draw_set_alpha(1);
	else draw_set_alpha(0.5);
	
	draw_text(settings.x, (settings.y + 200) + (i * TEXT_Y_MULT), string_upper(screens[currentScreen].optionText[i]));
	if(screens[currentScreen].optionTypes != undefined) {
		switch(screens[currentScreen].optionTypes[i]) {
			case 1:
				var T = variable_struct_get(variable_struct_get(global.settings, string_lower(screens[currentScreen].title) + "Settings"), screens[currentScreen].targetVars[i]) ? "Y" : "N";
				if(T == "Y") draw_set_color(c_green); //Bruh!
				else draw_set_color(c_red);
				draw_text(settings.x + (string_length(screens[currentScreen].optionText[i]) * (TEXT_X_MULT/2)) + 24, (settings.y + 200) + (i * TEXT_Y_MULT), T);
				draw_set_color(c_white);
			break;
			
			case 2:
				draw_text(settings.x + (string_length(screens[currentScreen].optionText[i]) * (TEXT_X_MULT/2)) + 32, (settings.y + 200) + (i * TEXT_Y_MULT), string(variable_struct_get(variable_struct_get(global.settings, string_lower(screens[currentScreen].title) + "Settings"), screens[currentScreen].targetVars[i])));
			break;
			
			case 3:
				if(i == variable_struct_get(variable_struct_get(global.settings, string_lower(screens[currentScreen].title) + "Settings"), screens[currentScreen].targetVars[0]) - 1) draw_set_alpha(1);
				else draw_set_alpha(0.5);
				draw_text(settings.x, (settings.y + 200) + (i * TEXT_Y_MULT), string_upper(screens[currentScreen].optionText[i]));
			break;
		}
	}
}

GUI_RESET;