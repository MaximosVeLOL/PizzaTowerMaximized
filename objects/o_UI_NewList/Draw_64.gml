draw_set_color(c_aqua);
draw_text(20, 20, "Interacting: " + string(interactingWithOption));

var current = screens[currentScreen];
draw_set_color(c_white);
draw_rectangle(current.position.x - 10, current.position.y, 960, 540, false);
if(current.background.sprite == noone) {
	draw_set_color(current.background.color);
	draw_rectangle(current.position.x, current.position.y, 960, 540, false);
}
else
	draw_sprite_tiled_area(current.background.sprite, -1, current.position.x + current.background.position.x, current.position.y + current.background.position.y, current.position.x, current.position.y, 960, 540);
draw_set_halign(current.background.hAlign);
draw_set_valign(current.background.vAlign);
draw_set_font(current.background.font);
draw_set_color(c_white);
draw_text(current.position.x + current.offset.x, current.position.y + 100, current.header);
for(var i = 0 ; i < array_length(current.options);i++) {

	draw_set_color((i == currentOption ? current.background.fontColor : c_gray));
	var option = current.options[i];
	var renderPos = new Vector(current.offset.x + current.position.x, current.offset.y + current.position.y);
	
	if(current.movementMode == 2)
		renderPos.x += (i > 0 ? string_width(current.options[i].name) + 20 : 0) - 32;
	else
		renderPos.y += (32 * i);
	draw_text(renderPos.x, renderPos.y, option.name);
	
	if(option.type == OptionType.Button) continue;
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	// - (round(string_width(option.name)) / 3) when working with fa_middle
	var offset = current.position.x + current.offset.x + string_width(option.name) + 25;
	renderPos.y += 10;
	switch(option.type) {
		
		case OptionType.Toggle:
			draw_set_color(c_black);
			var SIZE = 15;
			var XS = SIZE - 1;
			
			draw_rectangle(offset, renderPos.y, offset + SIZE, renderPos.y + SIZE, false);
			draw_set_color((variable_struct_get(current.targetStruct, option.event) ? c_green : c_red));
			draw_rectangle(offset + 1, renderPos.y + 1, offset + XS, renderPos.y + XS, false);
		break;
		
		case OptionType.Slider:
			if(i == currentOption && interactingWithOption)
				draw_set_alpha(1);
			else
				draw_set_alpha(0.5);
			var WIDTH = 75;
			var HEIGHT = 15;
			draw_healthbar(offset, renderPos.y, offset + WIDTH, renderPos.y + HEIGHT, variable_struct_get(current.targetStruct, option.event), c_black, c_green, c_green, 0, true, true);
		break;
		
		case OptionType.List:
			var WIDTH = 75;
			var HEIGHT = string_height("(");
			if(i == currentOption && interactingWithOption) {
				renderPos.y -= 32; //HACKK!!!
				for(var l = 0 ; l < array_length(option.event.values);l++) {
					var off = (l * HEIGHT);
					draw_set_color((l == listOption ? c_white : (l == option.event.selected ? c_gray : c_dkgray)));
					draw_rectangle(offset, renderPos.y + off, offset + WIDTH, renderPos.y + HEIGHT + off, false);
					draw_set_color(c_black);
					draw_text(offset + 10, renderPos.y + off - 2, option.event.values[l]);
				}
			}
		break;
	}
	
	draw_set_halign(current.background.hAlign);
	draw_set_valign(current.background.vAlign);
	draw_set_alpha(1);
}
GUI_RESET;