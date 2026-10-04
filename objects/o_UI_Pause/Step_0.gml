//if(!exist) return;
tileY--;
x++;
if(keyboard_check_pressed(vk_escape)) {
	instance_activate_all();
	intro = 2;
}
if(intro == 2)
	return;

option += GetInput("right", 1) - GetInput("left", 1);
if(GetInput("jump", 1)) {
	executeOption();
	return; //A little teeny tiny optimization!
}
if(mouse_check_button(mb_left)) {
	var sX = 197;
	var _x = window_mouse_get_x();
	var _y = window_mouse_get_y();
	for(var i = 0 ; i < array_length(sprites);i++) {
		var sW = sprite_get_width(sprites[i]);
		var sH = sprite_get_height(sprites[i]);
		if(_x >= sX && _x <= sX + sW && _y >= 270 && _y <= 270 + sH) {
			option = i;
			executeOption();
		}
		sX += sW;
	}
}