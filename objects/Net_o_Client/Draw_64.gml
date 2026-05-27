if(waitingForConnect) {
	connectTime += TIME_BASE;
	draw_set_color(c_black);
	draw_rectangle(0, 0, 961, 541, false);
	draw_set_color(c_white);
	draw_set_halign(fa_middle);
	var t = ".settings..";
	if(connectTime % 2 == 0) t = ".";
	else if(connectTime % 5 == 0) t = ".settings.";
	draw_text(480, 270, "CONNECTING" + t);
	if(connectTime >= 15) {
		PlaySound(MaxGUI_error);
		instance_destroy();
	}
}
if(typingMessage) {
	draw_set_font(global.misc.font);
	draw_text(o_Player.x, o_Player.bbox_top - 48, keyboard_string);
	GUI_RESET;
}