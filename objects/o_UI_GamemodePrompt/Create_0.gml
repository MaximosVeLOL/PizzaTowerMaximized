event_inherited();

onPressed = function(option) {
	//o_GameManager.level.mode;
	instance_activate_object(all);
	Log("Setting gamemode to " + string(currentOption));
	o_GameManager.level.gameMode = currentOption;
	var data = GetLevelInfo(o_GameManager.level.index);
	o_GameManager.gotoRoom(data.targetRoom, data.newPos, false, data.newSong, data.loopData);
	o_GameManager.level.update = true;
	o_Player.tempVar[0] = 1;
	return true;
};

screens = [
	new Screen("", [
		new Option("Normal", 4, undefined),
		new Option("Time Attack", 4, undefined),
		new Option("Sandbox", 4, undefined),
		//new Option("Versus", 3, undefined),
	], "Select a gamemode.", new Screen_Background(noone, c_black, 0, 0, c_white, c_gray, global.misc.font, fa_center, fa_middle)),
];
setAllToUpper();