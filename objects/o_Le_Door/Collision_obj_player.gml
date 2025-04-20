if(GetInput("up", 1)) {
	with(obj_player) {
		if(PLAYER_GROUNDED && velocity[0] == 0 && state != "door") {
			o_GameManager.gotoRoom(other.targetRoom, other.targetPos, newSong, true);
			setState("door");
		}
	}
}