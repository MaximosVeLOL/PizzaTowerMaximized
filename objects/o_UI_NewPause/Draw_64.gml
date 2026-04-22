if(intro != 1) {
		draw_surface(tempSurf, 0, 0);
		if(intro == 0) {
			y = lerp(y, (intro == 0 ? 0 : 550), 0.10);
			if(y <= 0.2) {
				y = 0;
				intro = 1;
			}
		}
		else {
			y = lerp(y, (intro == 0 ? 0 : 550), 0.25);
			if(y >= 547) {
				instance_activate_all();
				instance_destroy();
			}
		}
		draw_set_color(c_white);
		draw_rectangle(-1, y - 10, 961, y, false);
}
draw_set_color(bgColor);
draw_rectangle(-1, y, 961, 541, false);
draw_sprite_tiled_area(sprite_level_points_big, 0, x, y + tileY, 0, y, 960, 540);
var Y_POS = 420;
var Y_OFF = 36;
if(y <= Y_POS) {
	
	
	//Level stats
	draw_set_color(c_white);
	draw_set_font(global.misc.font);
	draw_text(0, y + Y_POS, o_GameManager.level.score);
	draw_text(0, y + Y_POS + Y_OFF, stats.time);
	
	//Render pizzakin
	var spr = ["shroom", "cheese", "tomato", "sausage", "pineapple"];
	var c = c_white;
	for(var i = 0 ; i < 5;i++) {
		if(variable_struct_get(o_GameManager.level.pizzakin, spr)) {
			c = c_white;
		}
		else c = c_black;
		draw_sprite_ext(asset_get_index("spr_pizzakin_" + spr[i] + "_idle"), 0, 20 + (i * 30), y + Y_POS + (Y_OFF * 2), 1, 1, 0, c, 1);
	}
	
	var X_POS = 480;
	
	//Level info
	draw_set_halign(fa_right);
	draw_text(952, y + Y_POS + Y_OFF, stats.name);
	draw_text(952, y + Y_POS + Y_OFF + Y_OFF, "0:00:00");
	GUI_RESET;
}
draw_set_font(-1);
for(var i = 0 ; i < array_length(sprites);i++) {
	draw_sprite(sprites[i], -1, 270 + (i * 105), y + 270);
}