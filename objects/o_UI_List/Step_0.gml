var moveY = GetInput("down", 1) - GetInput("up", 1);
var moveX = GetInput("right") - GetInput("left");
if(moveY != 0) {
	currentOption += moveY;
    PlaySound(sound_menuchange, false, false, true);
	if(currentOption == array_length(screens[currentScreen].optionText)) currentOption = 0;
	if(currentOption < 0) currentOption = array_length(screens[currentScreen].optionText) - 1;
}
if(GetInput("jump", 1)) {
	PlaySound(sound_menuchange, false, false, true);
	var opt = screens[currentScreen].optionTypes;
	var type = 0;
	
	//This is mainly used for the settings menu, where I should've hardcoded it to just the settings menu.
	if(is_array(opt)) type = opt[currentOption];
	switch(type) {
		case 3:
		case 0:
			screens[currentScreen].events[currentOption]();
		break;
			
		case 1:
			var _optionsStruct = variable_struct_get(global.settings, string_lower(screens[currentScreen].title) + "Settings");
			if(_optionsStruct == undefined) throw("Undefined option!");
			variable_struct_set(_optionsStruct, screens[currentScreen].targetVars[currentOption], !variable_struct_get(_optionsStruct, screens[currentScreen].targetVars[currentOption]));
		break;
	}
}
if(screens[currentScreen].optionTypes != undefined) {
	if(moveX != 0 && screens[currentScreen].optionTypes[currentOption] == 2) {
		var _optionsStruct = variable_struct_get(global.settings, string_lower(screens[currentScreen].title) + "Settings");
		if(_optionsStruct == undefined) throw("Undefined option!");
		variable_struct_set(_optionsStruct, screens[currentScreen].targetVars[currentOption], clamp(variable_struct_get(_optionsStruct, screens[currentScreen].targetVars[currentOption]) + (moveX/5), 0, 100) );
		
	}
}
if(GetInput("dash", 1) && array_length(lastScreens) > 0) {
	currentScreen = lastScreens[array_length(lastScreens) - 1];
	array_resize(lastScreens, array_length(lastScreens) - 1);
	
}