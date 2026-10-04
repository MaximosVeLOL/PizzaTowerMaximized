if(async_load[? "event_type"] == "gamepad discovered") {
	var pad = async_load[? "pad_index"];
	Log("Got controller for index " + string(pad));
	if(pad >= MAX_PLAYERS) LogError("Gamepad index is higher than supported players.");
	detectedControllers[pad] = true;
	if(global.settings.multiplayer.enabled) {
		o_MultiplayerHandler.AddPlayer(new Vector(o_Player.x, o_Player.y));
	}
}