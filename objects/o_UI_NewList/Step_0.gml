var current = screens[currentScreen];

if(current.animation != undefined && current.animation.update) {
	if(current.animation.introType <= IntroType.FromBottom) {
		current.position.y = BetterLerp(current.position.y, current.animation.targetPosition.y, 0.2);
		if(current.position.y == current.animation.targetPosition.y) {
			current.animation.update = false;
		}
	}
	else {
		current.position.x = BetterLerp(current.position.x, current.animation.targetPosition.x, 0.2);
		if(current.position.x == current.animation.targetPosition.x) {
			current.animation.update = false;
		}
	}
}
if(current.background.sprite != noone) {
	current.background.position.x += current.background.xSpeed;
	current.background.position.y += current.background.ySpeed;
}
//Detect inputs for each mode

var input = 0;
var curOpt = current.options[currentOption];
if(!interactingWithOption) {
	switch(current.movementMode) {
		case 0: //Both
			input = GetInput("down", 1) - GetInput("up", 1);
			if(input == 0) input = GetInput("right", 1) - GetInput("left", 1);
		break;
		
		case 1: //Up and down
			input = GetInput("down", 1) - GetInput("up", 1);
		break;
		
		case 2: //Left and right
			input = GetInput("right", 1) - GetInput("left", 1);
		break;
	}
	if(input != 0) {
		PlaySound(sound_menuchange, true);
		currentOption += input;
		if(currentOption < 0) currentOption = array_length(current.options) - 1;
		else if(currentOption >= array_length(current.options)) currentOption = 0;
	}
}
else {
	if(curOpt.type == OptionType.Slider) {
		input = GetInput("right", 0) - GetInput("left", 0);
		if(input != 0) variable_struct_set(current.targetStruct, curOpt.event, clamp(variable_struct_get(current.targetStruct, curOpt.event) + input, 0, 100));
	}
	else {
		if(GetInput("left", 1) || GetInput("dash", 1)) {
			interactingWithOption = false;
		}
		else {
		
			input = GetInput("down", 1) - GetInput("up", 1);
			listOption = clamp(listOption + input, 0, array_length(curOpt.event.values) - 1);
		}
	}
}
if(GetInput("jump", 1)) {
	
	switch(curOpt.type) {
		case OptionType.Button:
			if(variable_struct_exists(curOpt, "OnEvent"))
				curOpt.OnEvent();
			else {
				setScreen(curOpt.event);
			}
		return;
		
		case OptionType.Toggle:
			variable_struct_set(current.targetStruct, curOpt.event, !variable_struct_get(current.targetStruct, curOpt.event));
		return;
		
		case OptionType.Slider:
			

		break;
		
		case OptionType.List:
			
			if(interactingWithOption) {
				variable_struct_set(current.targetStruct, curOpt.event.targetVar, listOption);
				listOption = 0;
			}
			else curOpt.event.selected = variable_struct_get(current.targetStruct, curOpt.event.targetVar);
			//Show list
		break;
	}
	interactingWithOption = !interactingWithOption;
}
