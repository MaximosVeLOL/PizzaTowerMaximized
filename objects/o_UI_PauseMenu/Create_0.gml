event_inherited();
instance_deactivate_all(true);
screens = [
	new CreateScreen("PAUSE", ["RESUME", "OPTIONS", "RESTART", "QUIT"], [function(){instance_activate_all(); instance_destroy()}, function(){setScreen(1)}, function(){}, function(){setScreen(2)}]),
	new CreateScreen("OPTIONS", ["AUDIO", "VIDEO", "GAMEPLAY", "BACK"], [function(){setScreen(3)},function(){setScreen(4)}, function(){setScreen(5)}]),
	new CreateScreen("QUIT OPTIONS", ["QUIT TO MENU", "QUIT TO DESKTOP", "BACK"], []),
];