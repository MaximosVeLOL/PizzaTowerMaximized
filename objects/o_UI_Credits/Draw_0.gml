draw_set_color(c_black);
draw_set_halign(fa_center);
draw_rectangle(-10, -10, 970, 550, false);
draw_set_color(c_white);
//draw_text(50, 20, string(y));
draw_text(480, y, text);
if(pressed) {
	draw_set_halign(fa_left);
	draw_text(10, 520, "PRESS ANY KEY TO QUIT");
}