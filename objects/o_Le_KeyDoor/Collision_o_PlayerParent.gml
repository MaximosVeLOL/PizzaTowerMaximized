if(GetInput("up", 1, other.PD)) {
	with(o_PlayerParent) {
		if(PLAYER_GROUNDED && velocity[0] == 0 && state != "door" && inventory.key) {
			instance_create_depth(other.x,other.y,0, o_P_DeadEnemy, {sprite_index : sprite_level_door_key_gib});
			inventory.key = false;
			setState("door");
			tempVar[0] = 2;
			var door = other;
			with(instance_create_depth(other.x,other.y,other.depth, o_Le_Door)) {
				targetRoom = door.targetRoom;
				targetPos = door.targetPos;
				newSong = door.newSong;
				loopData = door.loopData;
			}
			instance_destroy(other);
		}
	}
}
if(other.state == "door" && round(other.image_index) == other.image_number && !instance_exists(o_UI_DoorTrans)) o_GameManager.gotoRoom(targetRoom, targetPos, true, newSong, loopData);