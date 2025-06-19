event_inherited();
keys = ["up", "down", "left", "right", "jump", "dash", "shoot"];
targetProfile = 1;
act = function() {
	currentScreen = 1;
	io_clear();
}
settings.y = -50;
lastKeyInput = vk_nokey;
screens = [
	new CreateScreen("KEY BIND EDITOR", ["up", "down", "left", "right", "jump", "dash", "shoot", "back"], [act, act, act, act, act, act, act, function(){instance_destroy();instance_activate_object(o_UI_Settings)}]),
	new CreateScreen("PLEASE INPUT A KEY", array_create(array_length(keys), ""), [function(){}]),
];