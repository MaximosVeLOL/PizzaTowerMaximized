event_inherited();

onPressed = function(option) {
	o_GameManager.level.mode = "";
};

screens = [
	new Screen("", [
		new Option("Normal", 3, undefined),
		new Option("Time Attack", 3, undefined),
		new Option("Sandbox", 3, undefined),
		//new Option("Versus", 3, undefined),
	], "Select a gamemode."),
];