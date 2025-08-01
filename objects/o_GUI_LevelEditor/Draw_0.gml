if(!visible) return;
//draw_sprite_stretched(sprite_editor_background, -1, -room_width, -room_height, room_width * 2, room_height * 2);
var pos = 0;
while(pos < room_width) {
	draw_line(pos, 0, pos, room_height);
	pos += gridSize;
}
pos = 0;
while(pos < room_height) {
	draw_line(0, pos, room_width, pos);
	pos += gridSize;
}
draw_set_color(c_red);
var INV_SIZE = 1;
draw_rectangle(-INV_SIZE, 0, INV_SIZE, room_height, false);
draw_rectangle(room_width - INV_SIZE, 0, room_width + INV_SIZE, room_height, false);
draw_rectangle(0,-INV_SIZE, room_width, INV_SIZE, false);
draw_rectangle(0,room_height - INV_SIZE, room_width, room_height + INV_SIZE, false);
GUI_RESET;