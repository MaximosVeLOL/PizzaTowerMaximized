function CreateScreen(_title, _options, _events, _types = undefined, _targetVars = undefined) constructor {
	title = _title;
	optionText = _options;
	events = _events;
	optionTypes = _types;
	targetVars = _targetVars;
}
screens = [new CreateScreen("Test", ["Test", "Test", "Test", "Test"], [function(){Log("Test")}, game_restart])];
currentScreen = 0;
lastScreens = [];
currentOption = 0;
subOption = 0;
setScreen = function(index) {
	array_resize(lastScreens, array_length(lastScreens) + 1);
	lastScreens[array_length(lastScreens) - 1] = currentScreen;
	currentScreen = index;
	currentOption = 0;
}
settings = {
	x : 480,
	y : 0,
	background : {
		render : true,
		color : c_black
	},
	text : {
		font : global.misc.font,
		color : c_white,
	},
};
/* Types:
	0 - Text/Button
	1 - Toggle,
	2 - Slider,
	3 - Runs one single function for an event
*/
image_speed = 0.25;