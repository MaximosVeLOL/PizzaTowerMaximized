if(GetInput("up", 1)) {
	with(o_Player) {
		if(PLAYER_GROUNDED && velocity.x == 0 && state != "door") {
			if(!global.settings.audioSettings.muteAll) {
				if(string_count("Secret", room_get_name(other.targetRoom)) > 0) o_MusicManager.tempPlaySong(music_secret);
				if(string_count("Secret", room_get_name(room)) > 0) o_MusicManager.stopTempSong();
			}
			setState("door");
			x = other.x;
		}
	}
}
if(other.state == "door" && round(other.image_index) == other.image_number && !instance_exists(o_UI_DoorTrans) && !instance_exists(o_UI_DoorWin)) {
	if(global.settings.playerSettings.moveSet == Moveset.PreETB && isPreETBDoor) {
		instance_create_depth(x,y,0,o_UI_DoorWin);
		return;
	}
	if(instance_exists(o_GameManager)) o_GameManager.gotoRoom(targetRoom, targetPos, true, newSong, loopData);
	else {
		room_goto(targetRoom);
		o_Player.x = targetPos[0];
		o_Player.y = targetPos[1];
		if(!global.settings.audioSettings.muteAll && newSong != -1) o_MusicManager.playNewSong(newSong, loopData);
	}
}