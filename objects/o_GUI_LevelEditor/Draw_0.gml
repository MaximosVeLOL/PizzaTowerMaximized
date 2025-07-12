if(!visible) return;
//draw_sprite_stretched(sprite_editor_background, -1, -room_width, -room_height, room_width * 2, room_height * 2);
for(var i=0; i<= max(room_width, room_height); i+=32) {
	    draw_line(0, i, room_width, i);
	    draw_line(i, 0, i, room_height);
}
draw_set_color(c_red);
var INV_SIZE = 1;
draw_rectangle(-INV_SIZE, 0, INV_SIZE, room_height, false);
draw_rectangle(room_width - INV_SIZE, 0, room_width + INV_SIZE, room_height, false);
draw_rectangle(0,-INV_SIZE, room_width, INV_SIZE, false);
draw_rectangle(0,room_height - INV_SIZE, room_width, room_height + INV_SIZE, false);
GUI_RESET;