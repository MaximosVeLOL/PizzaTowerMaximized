event_inherited();
if(usingBack) {
	var value = (GetInput("jump", 1) && array_length(history) > 0);
	//show_message(value);
	if(GetInput("right", 1) || value) {
		usingBack = false;
		screens[currentScreen].movementMode = 1;
		screens[currentScreen].background.fontColor = c_white;
		if(value) {
			if(currentScreen == 0) {
				instance_destroy();
				if(room == Room_MainMenu)
					instance_activate_object(o_UI_MainMenu);
				else instance_activate_object(o_UI_NewPause);
			}
			else {
				setScreen(array_last(history));
				repeat(2)
					array_pop(history);
			}
		}
	}
}
if(GetInput("left", 1) && !interactingWithOption) {
	usingBack = true;
	screens[currentScreen].movementMode = 3;
	screens[currentScreen].background.fontColor = c_gray;
}
