event_inherited();

usingBack = false;

var basicAnim = function(){return new Screen_Animation(true, new Vector(480, 0), IntroType.FromRight);};
var normalOffset = new Vector(64, 270);
//This causes a fatal error?
//function Screen_SettingOption(pName, pType, pEvent, pExplanation) : Option(pName, pType, pEvent) constructor {
//	explanation = pExplanation;
//}

screens = [
	new Screen("main", [
		new Option("Audio", OptionType.Button, "audio"),
		new Option("Video", OptionType.Button, "video"),
		new Option("Gameplay", OptionType.Button, "game"),
		//new Option("hi", OptionType.Button, 0),
	], "Settings", new Screen_Background(sprite_hud_bg_main, 1, 1), 1, new Screen_Animation(true, new Vector(680, 0), IntroType.FromRight), new Vector(960, 0), normalOffset),
	/*		sfxVolume : 100,
		musicVolume : 100,
		masterVolume : 100,
		muteAll : false,
		surroundSound : false,
	*/
	new Screen("audio", [
		new Option("SFX Volume", OptionType.Slider, "sfxVolume"),
		new Option("Music Volume", OptionType.Slider, "musicVolume"),
		new Option("Master Volume", OptionType.Slider, "masterVolume"),
		new Option("Mute all", OptionType.Toggle, "muteAll"),
		new Option("Use surround sound", OptionType.Toggle, "surroundSound"),
	], "Audio", new Screen_Background(sprite_hud_bg_audio, 1, 1), 1, basicAnim(), new Vector(960, 0), normalOffset, global.settings.audio),
	
	new Screen("video", [
		new Option("Fullscreen", OptionType.Toggle, "fullscreen"),
		new Option("Video type", OptionType.List, new Screen_List("resolutionOpt", ["SMALL (480x270)", "NORMAL (960x540)", "BIG (1920x1080)", "BACK"])),
		new Option("Use VSync", OptionType.Toggle, "vSync"),
	
	], "Video", new Screen_Background(sprite_hud_bg_video, 1, 1), 1, basicAnim(), new Vector(960, 0), normalOffset, global.settings.video),
	
	new Screen("game", [
		new Option("Debug enabled", OptionType.Toggle, "debugEnabled"),
		new Option("Gooner mode enabled", OptionType.Toggle, "goonerMode"),
		new Option("Player settings", OptionType.Button, "player"),
		new Option("Multiplayer settings", OptionType.Button, "multi"),
	], "Gameplay", new Screen_Background(noone, c_purple, 0, 0, ComicSans), 1, basicAnim(), new Vector(960, 0), normalOffset, global.settings.gameplay),
	
	new Screen("player", [
		new Option("Moveset", OptionType.List, new Screen_List("moveSet", ["Pre ETB", "ETB"])),
		new Option("(ETB) Use Old Mach 3", OptionType.Toggle, "ETB_useOldMach3"),
		new Option("(Pre ETB) Better running", OptionType.Toggle, "PreETB_betterRunning"),
		new Option("Interact with water", OptionType.Toggle, "waterInteraction"),
	], "Player", new Screen_Background(noone, c_purple, 0, 0, ComicSans), 1, basicAnim(), new Vector(960, 0), normalOffset, global.settings.player),
	
	new Screen("multi", [
		new Option("placeholder", OptionType.Button, 0),
	], "Multiplayer")
];
setAllToUpper();