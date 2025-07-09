if(instance_exists(o_GameManager)) if(!instance_exists(o_UI_FadeTrans)) o_GameManager.gotoRoom(targetRoom, targetPos, false, newSong, loopData);
else {
	room_goto(targetRoom);
	o_PlayerParent.x = targetPos[0];
	o_PlayerParent.y = targetPos[1];
}