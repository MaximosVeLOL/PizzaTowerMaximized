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
	draw_sprite_general(sp, 0, 0, 0, sprite_get_width(sp), sprite_get_height(sp), Grid(mouse_x), Grid(mouse_y), 1, 1, 0, c_white, c_white, c_white, c_white, 1);
	//draw_sprite(sp, 0, Grid(mouse_x), Grid(mouse_y));
}
if(editObject != noone) {
	draw_set_color(c_green);
	draw_ellipse(editObject.x, editObject.y, editObject.bbox_right, editObject.bbox_bottom, false);
}
GUI_RESET;