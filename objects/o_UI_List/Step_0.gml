var moveY = GetInput("down", 1) - GetInput("up", 1);
if(moveY != 0) {
	currentOption += moveY;
	if(currentOption == array_length(screens[currentScreen].optionText)) currentOption = 0;
	if(currentOption < 0) currentOption = array_length(screens[currentScreen].optionText) - 1;
}