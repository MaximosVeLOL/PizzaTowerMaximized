//draw_text(120,20, "Press (jump) on controller to continue");
if(style == 1) {
	if(image_yscale == 0) {
		image_xscale += 0.25;
		image_angle -= 4;
		if(image_angle <= -640) image_yscale = 1;
	}
	else if(image_yscale == 1) {
		image_xscale -= 0.25;
		image_angle += 4;
		if(image_angle >= 0) {
			image_xscale = 1;
			image_angle = 0;
			image_yscale = 2;
		}
	}
	draw_text_ext_transformed(480, 270, text, 16, 1000, image_xscale, image_xscale, image_angle);
	return;
}
draw_text(480, 270, currentText);
if(global.settings.gameplay.goonerMode) {
	draw_set_color(c_red);
	draw_text(480, 480, "GOONER MODE ENABLED");
	draw_set_color(c_white);
}