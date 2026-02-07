event_inherited();
if(instance_exists(o_MusicManager)) o_MusicManager.pauseMusic();
screens = [
	new CreateScreen("PAUSE", ["RESUME", "OPTIONS", "RESTART", "QUIT"], [instance_destroy, function(){instance_deactivate_object(self);instance_create_depth(0,0,0,o_UI_Settings);}, function(){instance_destroy();instance_activate_all();if(instance_exists(o_GameManager)) o_GameManager.restartLevel();}, function(){setScreen(1)}]),
	new CreateScreen("QUIT OPTIONS", ["QUIT TO DEMO ROOM", "QUIT TO DESKTOP", "QUIT TO MENU", "BACK"], [function(){if(room == Room_DemoRoom){return;}instance_activate_all();o_GameManager.endLevel(false, true)  }, function(){game_end();}, function(){show_message("Placeholder!")}, function(){setScreen(0);}]),
];





instance_deactivate_all(true);