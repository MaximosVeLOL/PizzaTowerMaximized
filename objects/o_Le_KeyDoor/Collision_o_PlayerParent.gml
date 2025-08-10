if(GetInput("up", 1)) {
	with(o_PlayerParent) {
		if(PLAYER_GROUNDED && velocity[0] == 0 && state != "door" && inventory.key) {
			instance_create_depth(x, y, 0, o_P_DeadEnemy, {sprite_index : sprite_level_door_key_gib}); //I have a theory: What if door sprites changed their origin just to make key particle aligned properly?
			//instance_create_depth(other.x,other.y,0, o_P_DeadEnemy, {sprite_index : sprite_level_door_key_gib});
			inventory.key = false;
			
			setState("door");
			tempVar[0] = 2; //M_OPTI - Wasting CPU cycles...
			if(global.settings.playerSettings.moveSet == Moveset.PreETB && other.isPreETBDoor) {
				tempVar[0] = 3;
				instance_create_depth(other.x, other.y, 0, o_UI_DoorWin);
			}
			if(global.settings.gameplaySettings.fpsSave != FPSSaveMode.UselessRemover) {
				var door = other;
				with(instance_create_depth(other.x,other.y,other.depth, o_Le_Door)) {
					targetRoom = door.targetRoom;
					targetPos = door.targetPos;
					newSong = door.newSong;
					loopData = door.loopData;
				}
				instance_destroy(door);
				//delete door;
			}
		}
	}
}
if(other.state == "door" && round(other.image_index) == other.image_number && !instance_exists(o_UI_DoorTrans) && !instance_exists(o_UI_DoorWin)) {
	if(instance_exists(o_GameManager)) o_GameManager.gotoRoom(targetRoom, targetPos, true, newSong, loopData);
	else {
		room_goto(targetRoom);
		o_PlayerParent.x = targetPos[0];
		o_PlayerParent.y = targetPos[1];
		if(instance_exists(o_MusicManager) && newSong != -1) o_MusicManager.playNewSong(newSong, loopData);
	}	
}