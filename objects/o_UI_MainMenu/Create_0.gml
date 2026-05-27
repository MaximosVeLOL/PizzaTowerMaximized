event_inherited();
var files = 5;
var bg = new Screen_Background(noone - 1, noone, 0, 0, c_white, c_gray, global.misc.font, fa_center, fa_top);
screens = [
	new Screen("m", [
		new Option("Play", OptionType.Button, 1),
		new Option("Options", OptionType.Button, function(){instance_deactivate_object(self);instance_create(0, 0, o_UI_Settings);}),
		new Option("Credits", OptionType.Button, function(){instance_deactivate_object(self);instance_create(0, 0, o_UI_Credits);}),
		new Option("Quit", OptionType.Button, function(){game_end(0);})
	], "", bg, 0),
	new Screen("p", [
		new Option("Regular", OptionType.Button, 2),
		new Option("Level Select", OptionType.Button, function(){instance_deactivate_object(self);instance_create(0, 0, o_UI_LevelSelect);}),
		new Option("Level Editor", OptionType.Button, function(){room_goto(Room_LevelEditor_Menu);}),
		new Option("Online", OptionType.Button, function(){room_goto(Net_Room_NetGame);}),
		new Option("Back", OptionType.Button, 0),
	], "", bg),
	new Screen("r", array_create_ext(files + 1, function(index){if(index < 5) {return new Option("File " + string(index + 1), 5, undefined)} else {return new Option("Back", OptionType.Button, 1)}}), "", bg),
];
setAllToUpper();
onPressed = function(option) {
	global.settings.saveFileIndex = currentOption;
	if(instance_exists(o_GameManager)) o_GameManager.sessions.save++;
    o_UI_MainMenu_Pep.active = true;
    PlaySound(sound_menuselect, false, false, true);
	if(os_browser != browser_not_a_browser) show_message("Save file support is not on browser. You cannot save settings, and progress.");
	instance_destroy();
}

o_MusicManager.playNewSong(music_mainmenu);