if(instance_exists(o_GameManager)) {
	if( !instance_exists(o_UI_FadeTrans) ) o_GameManager.gotoRoom(targetRoom, targetPos, false, newSong, loopData);
}
else {
	room_goto(targetRoom);
	o_Player.x = targetPos[0];
	o_Player.y = targetPos[1];
}