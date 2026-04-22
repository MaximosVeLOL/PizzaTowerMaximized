tileY++;
x++;
option += GetInput("right", 1) - GetInput("left", 1);

if(keyboard_check_pressed(vk_escape)) {
	intro = 2;
}