
//We still waste 
if(!displayMenu) {
	draw_text(0, 520 - menuY, serverLog);
	GUI_RESET;
	return;
}
draw_set_font(global.misc.font);
draw_text(20, 20, "You are a server! You are not visible to other players.");