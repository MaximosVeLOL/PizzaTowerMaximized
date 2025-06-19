event_inherited();
instance_deactivate_all(true);
//Enable some needed objects
instance_activate_object(o_GameManager);
instance_activate_object(o_DEBUG_Console); //Crashes the game on game exit
//instance_activate_object(o_MusicManager);
//instance_activate_object(o_Camera);
//o_MusicManager.tempPlaySong(music_knight);
screens = [
	new CreateScreen("PAUSE", ["RESUME", "OPTIONS", "RESTART", "QUIT"], [function(){instance_activate_all(); instance_destroy();o_MusicManager.stopTempSong();}, function(){instance_deactivate_object(self);instance_create_depth(0,0,0,o_UI_Settings);}, function(){}, function(){setScreen(1)}]),
	new CreateScreen("QUIT OPTIONS", ["QUIT TO MENU", "QUIT TO DESKTOP", "BACK"], [function(){game_restart();}, function(){game_end();}]),
];