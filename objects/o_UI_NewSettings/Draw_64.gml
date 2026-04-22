draw_set_color(c_black);
draw_rectangle(0, 0, 960, 540, false);
draw_set_color(c_aqua);
draw_text(20, 40, "Using back: " + string(usingBack));
event_inherited();
draw_set_color((usingBack ? c_white : c_gray));
draw_text(20, 520, "BACK");