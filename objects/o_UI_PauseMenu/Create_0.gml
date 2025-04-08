event_inherited();
screens = [
	new CreateScreen("PAUSE", ["Resume", "Options", "Quit"], [instance_destroy, function(){setScreen(1)}, function(){setScreen(2)}]),
	new CreateScreen("OPTIONS", ["WIP"], []),
	new CreateScreen("QUIT OPTIONS", ["QUIT TO MENU", "QUIT TO DESKTOP", "BACK"], []),
];