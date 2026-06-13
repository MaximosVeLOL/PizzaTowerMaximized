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
if(disableSelection) {
    draw_set_color(c_white);
    draw_set_font(global.misc.font);
    draw_text(32, 540 - 48, "BACK");
    return;
}
else {
    draw_set_color(c_gray);
    draw_set_font(-1);
    draw_text(10, 540 - 20, "BACK");
}