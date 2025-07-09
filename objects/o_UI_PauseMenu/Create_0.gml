event_inherited();
instance_deactivate_all(true);
screens = [
	new CreateScreen("PAUSE", ["RESUME", "OPTIONS", "RESTART", "QUIT"], [function(){instance_activate_all(); instance_destroy();}, function(){instance_deactivate_object(self);instance_create_depth(0,0,0,o_UI_Settings);}, function(){instance_destroy();instance_activate_all();if(instance_exists(o_GameManager)) o_GameManager.restartLevel();}, function(){setScreen(1)}]),
	new CreateScreen("QUIT OPTIONS", ["QUIT TO MENU", "QUIT TO DESKTOP", "BACK"], [function(){game_restart();}, function(){game_end();}]),
];