event_inherited();
o_MusicManager.toggleMusicPlaying();
screens = [
	new CreateScreen("PAUSE", ["RESUME", "OPTIONS", "RESTART", "QUIT"], [instance_destroy, function(){instance_deactivate_object(self);instance_create_depth(0,0,0,o_UI_Settings);}, function(){instance_destroy();instance_activate_all();if(instance_exists(o_GameManager)) o_GameManager.restartLevel();}, function(){setScreen(1)}]),
	new CreateScreen("QUIT OPTIONS", ["QUIT TO DEMO ROOM", "QUIT TO DESKTOP", "BACK"], [function(){instance_activate_all();o_GameManager.goToHub();  }, function(){game_end();}]),
];





instance_deactivate_all(true);