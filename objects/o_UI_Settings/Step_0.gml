event_inherited();
var moveX = (GetInput("right", I_DOWN) - GetInput("left", I_DOWN));
if(disableSelection) {
    if(GetInput("jump", I_DOWN)) {
        if(currentScreen == 0) {
            instance_destroy();
			ApplySettings();
            if(room == Room_MainMenu)
                instance_activate_object(o_UI_MainMenu);
            else
				//o_UI_Pause.exist = true;
                instance_activate_object(o_UI_Pause);
            return;
        }
        else {
            setScreen(array_last(history));
            repeat(2) {
                array_pop(history);
            }
        }
    }
    if(moveX == 1)
        disableSelection = false;
}
else {
    if(moveX == -1) {
        disableSelection = true;
    } 
}
