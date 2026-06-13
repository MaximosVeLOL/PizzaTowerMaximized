if(level.update) {
	if(level.gameMode == Gamemode.TimeAttack) {
		draw_set_font(global.misc.font);
		draw_set_halign(fa_center);
		draw_text(480, 100, string(GetAsTime(level.timer)));
		if(level.lap > 0) {
			draw_text(480, 165, "LAP " + string(level.lap + 1));
		}
		GUI_RESET;
	}
}