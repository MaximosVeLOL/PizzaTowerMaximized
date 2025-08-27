event_inherited();
setPlayerMoveset = function() {
	global.settings.playerSettings.moveSet = currentOption;
    setScreen(4);
}
setScreenType = function() {
	global.settings.videoSettings.resolutionOpt = currentOption;
	setScreen(2);
}
screens = [
	new CreateScreen("SETTINGS", ["AUDIO", "VIDEO", "GAMEPLAY", "BACK"], [function(){setScreen(1)}, function(){setScreen(2)}, function(){setScreen(4)}, function(){if(room != Room_MainMenu) instance_activate_object(o_UI_PauseMenu);else instance_activate_object(o_UI_MainMenu); instance_destroy(); if(os_browser == browser_not_a_browser) {SaveSettings(); } }]),
	new CreateScreen("AUDIO", ["MUSIC VOLUME", "SFX VOLUME", "MASTER VOLUME", "MUTE ALL", "USE SURROUND SOUND", "BACK"], [0,0,0,0,0,function(){setScreen(0);}], [2,2,2,1,1,0], ["musicVolume", "sfxVolume", "masterVolume", "muteAll", "surroundSound"] ),
	new CreateScreen("VIDEO", ["FULLSCREEN", "USE VSYNC", "BACK"], [0, 0, function(){setScreen(0);}], [1,1,0], ["fullscreen", "vsync"] ),
	new CreateScreen("VIDEO", ["SMALL (480x270)", "NORMAL (960x540)", "BIG (1920x1080)", "BACK"], [setScreenType, setScreenType, setScreenType, function(){setScreen(2)}]),
	new CreateScreen("GAMEPLAY", ["DEBUG ENABLED", "GOONER MODE ", "PLAYER SETTINGS", "KEY BINDS", "BACK"], [0,0, function(){setScreen(5)}, function(){instance_create_depth(0,0,0,o_UI_KeyBinds);instance_deactivate_object(self);}, function(){setScreen(0)}], [1,1,0,0,0], ["debugEnabled", "goonerMode"]),
	new CreateScreen("PLAYER", ["SET MOVESET", "MOVESET SETTINGS", "BACK"], [function(){setScreen(6)}, function(){setScreen(7)}, function(){setScreen(0)}]),
	new CreateScreen("PLAYER", ["PRE ETB", "ETB (DEFAULT)", "BACK"], [setPlayerMoveset, setPlayerMoveset, function(){setScreen(4);}], [3,3,0], ["moveSet"]),
	new CreateScreen("PLAYER", ["(ETB) USE OLD MACH3", "(PRE ETB) BETTER RUNNING", "BACK"], [0,0, function(){setScreen(4)}], [1,1,0], ["ETB_useOldMach3", "PreETB_betterRunning"]),
	
];