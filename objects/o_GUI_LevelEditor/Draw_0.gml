draw_sprite_stretched(sprite_editor_background, -1, -room_width, -room_height, room_width * 2, room_height * 2);
for(var i=0; i<= max(room_width, room_height); i+=32) {
	    draw_line(0, i, room_width, i);
	    draw_line(i, 0, i, room_height);
}
draw_set_color(c_red);
draw_rectangle(-5, 0, 5, room_height, false);