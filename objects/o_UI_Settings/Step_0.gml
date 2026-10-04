if(IS_MOBILE) {
	if(mouse_check_button(mb_left)) {
		if(window_mouse_get_x() <= 50 && window_mouse_get_y() <= 50) {
			Log("Quitting by touch...");
			instance_destroy();
			ApplySettings();
			io_clear();
			return;
		}
		
	}
}
event_inherited();

if(disableSelection) {
    if(GetInput("jump", I_DOWN)) {
        if(currentScreen == 0) {
            instance_destroy();
			ApplySettings();
			io_clear();
            if(room == Room_MainMenu)
                instance_activate_object(o_UI_MainMenu);
            else
				//o_UI_Pause.exist = true;
                instance_activate_object(o_UI_Pause);
				//o_UI_Pause.exist = true;
            return;
        }
        else {
            setScreen(array_last(history));
            repeat(2) {
                array_pop(history);
            }
        }
    }
    if(GetInput("right", I_DOWN))
        disableSelection = false;
}
else {
    if(GetInput("left", I_DOWN)) {
        disableSelection = true;
    } 
}
