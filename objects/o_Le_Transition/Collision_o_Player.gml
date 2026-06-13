if(global.settings.multiplayer.enabled) {
	o_Player.x = other.x;
	o_Player.y = other.y;
}
if( !instance_exists(o_UI_FadeTrans) ) o_GameManager.gotoRoom(targetRoom, targetPos, false, newSong, loopData);