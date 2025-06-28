event_inherited();
settings.background.render = false;
o_MusicManager.playNewSong(music_mainmenu);
startGame = function() {
    o_UI_MainMenu_Pep.active = true;
    PlaySound(sound_menuselect, false, false, true);
	if(os_browser == browser_not_a_browser) {
		global.settings.saveFileIndex = currentOption;
		LoadSettings();
		ApplySettings();
	}
	else show_message("Save file support is not on browser. You cannot save settings, and progress.");
	instance_deactivate_object(self);
}
screens = [
	new CreateScreen("", ["PLAY", "OPTIONS", "CREDITS", "QUIT"], [function(){setScreen(1);}, function(){instance_deactivate_object(self);instance_create_depth(0,0,0,o_UI_Settings)}, function(){instance_deactivate_object(self);instance_create_depth(0,0,0,o_UI_Credits)}, function(){game_end(1);}]),
	new CreateScreen("", ["FILE 1", "FILE 2", "FILE 3", "BACK"], [startGame, startGame, startGame, function(){setScreen(0);settings.background.render = false}]),
]