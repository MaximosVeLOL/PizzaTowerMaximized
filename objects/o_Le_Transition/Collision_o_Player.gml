if(instance_exists(o_GameManager)) {
	if(global.settings.multiplayerSettings.enabled) {
		o_Player.x = other.x;
		o_Player.y = other.y;
	}
	if( !instance_exists(o_UI_FadeTrans) ) o_GameManager.gotoRoom(targetRoom, targetPos, false, newSong, loopData);
}
else {
	room_goto(targetRoom);
	o_Player.x = targetPos.x;
	o_Player.y = targetPos.y;
}