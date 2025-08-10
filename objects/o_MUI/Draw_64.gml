for(var i = 0; i < array_length(allObjects);i++) {
	if(allObjects[i].active) {
		allObjects[i].Exectute();
		if(false) {
			draw_set_color(c_purple);
			draw_rectangle(allObjects[i].rect.x, allObjects[i].rect.y, allObjects[i].rect.x + allObjects[i].rect.width, allObjects[i].rect.y + allObjects[i].rect.height, false);
		}
		GUI_RESET;
		}
}