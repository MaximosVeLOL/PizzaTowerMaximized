draw_set_color(c_black);
if(bgPos != 0) {
	bgPos = BetterLerp(bgPos, 0, 0.20);
	if(instance_exists(o_UI_Pause) && bgPos == 0)
		instance_deactivate_object(o_UI_Pause);
}
draw_rectangle(0, bgPos, 960, 540, false);
//draw_set_color(c_aqua);
//draw_text(20, 40, "Using back: " + string(usingBack));
event_inherited();
if(usingBack) {
	draw_set_color(c_white);
	//draw_rectangle(0, 480, 164, 540, false);
	draw_set_font(global.misc.font);
	draw_text(20, bgPos + 500, "BACK");
}
else {
	draw_set_color(c_gray);
	draw_text(20, bgPos + 520, "BACK");
}