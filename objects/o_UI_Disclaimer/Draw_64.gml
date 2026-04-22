draw_text(120,20, "Press A on XBOX to continue");
draw_text(480, 270, currentText);
if(global.settings.gameplay.goonerMode) {
	draw_set_color(c_red);
	draw_text(480, 480, "GOONER MODE ENABLED");
	draw_set_color(c_white);
}