event_inherited();
if(usingBack) {
	//show_message(value);
	if(GetInput("right", 1) || GetInput("jump", 1)) {
		usingBack = false;
		screens[currentScreen].movementMode = 1;
		screens[currentScreen].background.fontColor = c_white;
		if(GetInput("jump", 1)) {
			if(currentScreen == 0) {
				instance_destroy();
				instance_activate_object((room == Room_MainMenu ? o_UI_MainMenu : o_UI_Pause));
				return;
			}
			if(array_length(history) > 0) {
				setScreen(array_last(history));
				//History writes same index
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
