var posX = 0;
var posY = 0;
while(posX < room_width) {
	draw_line(posX, 0, posX, room_height);
	posX += 32;
}
while(posY < room_height) {
	draw_line(0, posY, room_width, posY);
	posY += 32;
}


if(mode == "place" && selectedObject != noone) {
	var sp = object_get_sprite(selectedObject);
	if(sp == -1) sp = sprite_editor_unknown;
	draw_sprite(sp, 0, Grid(mouse_x), Grid(mouse_y));
}
GUI_RESET;