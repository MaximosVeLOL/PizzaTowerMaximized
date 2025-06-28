if(GetInput("up", 1, other.PD)) {
	with(o_PlayerParent) {
		if(PLAYER_GROUNDED && velocity[0] == 0 && state != "door") {
			if(string_count("Secret", room_get_name(other.targetRoom)) > 0) o_MusicManager.tempPlaySong(music_secret);
			if(string_count("Secret", room_get_name(room)) > 0) o_MusicManager.stopTempSong();
			setState("door");
			x = other.x;
		}
	}
}
if(other.state == "door" && round(other.image_index) == other.image_number && !instance_exists(o_UI_DoorTrans)) o_GameManager.gotoRoom(targetRoom, targetPos, true, newSong, loopData);