draw_self();
for(var i = 0 ; i < delay;i++) {
	draw_set_color(c_white);
	draw_rectangle(follow[i].x - 10, follow[i].y - 10, follow[i].x + 10, follow[i].y + 10, false);
	draw_set_color(c_black);
	draw_text(follow[i].x - 10, follow[i].y - 10, string(i));
}
GUI_RESET;