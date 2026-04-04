//Refactored! This looks much better!
with(other) {
	if(state == "door") {
		if(IMAGE_COMPLETE & !instance_exists(o_UI_DoorTrans) && !instance_exists(o_UI_DoorWin)) {
			if(global.settings.playerSettings.moveSet == Moveset.PreETB && isPreETBDoor) {
				instance_create_depth(x,y,0,o_UI_DoorWin);
				return;
			}
			if(instance_exists(o_GameManager)) o_GameManager.gotoRoom(other.targetRoom, other.targetPos, true, other.newSong, other.loopData);
			else {
				room_goto(targetRoom);
				o_Player.x = targetPos[0];
				o_Player.y = targetPos[1];
				if(!global.settings.audioSettings.muteAll && newSong != -1) o_MusicManager.playNewSong(other.newSong, other.loopData);
			}
		}	
	}
	else {
		if(GetInput("up", 1, playerID)) {
			if(PLAYER_GROUNDED && velocity.x == 0) {
				if(!global.settings.audioSettings.muteAll) {
					if(string_count("Secret", room_get_name(other.targetRoom)) > 0) o_MusicManager.tempPlaySong(music_secret);
					if(string_count("Secret", room_get_name(room)) > 0) o_MusicManager.stopTempSong();
				}
				setState("door");
				x = other.x;
			}
		}
	}
}
