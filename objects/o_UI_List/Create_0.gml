instance_deactivate_all(true);
function CreateScreen(_title, _options, _events, _types = undefined) constructor {
	title = _title;
	optionText = _options;
	events = _events;
	optionTypes = _types;
}
screens = [new CreateScreen("Test", ["Test", "Test", "Test", "Test"], [function(){Log("Test")}, game_restart])];
currentScreen = 0;
currentOption = 0;
targetSetting = false;
setScreen = function(index) {
	currentScreen = index;
}

/* Types:
	0 - Text/Button
	1 - Toggle,
	2 - Slider,
*/