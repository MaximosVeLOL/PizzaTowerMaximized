//Refactored with key stuff too!
with(other) {
	if(state == "door") {
		if(IMAGE_COMPLETE && !instance_exists(o_UI_DoorTrans) && !instance_exists(o_UI_DoorWin)) {
			show_message("PreETB: " + string(other.isPreETBDoor));
			if(global.settings.playerSettings.moveSet == Moveset.PreETB && other.isPreETBDoor) {
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
			if(PLAYER_GROUNDED && velocity.x == 0 && (global.settings.multiplayerSettings.enabled ? GetPlayer(0).inventory.key : o_Player.inventory.key)) {
				//With all players
				o_Player.setState("door");
				o_Player.tempVar[0] = 2; //M_OPTI - Wasting CPU cycles...
				o_Player.x = other.x;
				//Whatevers
				o_Player.inventory.key = false;
				
				instance_create_depth(x, y, 0, o_P_DeadEnemy, {sprite_index : sprite_level_door_key_gib}); //I have a theory: What if door sprites changed their origin just to make key particle aligned properly?
				if(global.settings.gameplaySettings.fpsSave != FPSSaveMode.UselessRemover) {
					var door = other;
					with(instance_create_depth(other.x,other.y,other.depth, o_Le_Door)) {
						targetRoom = door.targetRoom;
						targetPos = door.targetPos;
						newSong = door.newSong;
						loopData = door.loopData;
						isPreETBDoor = door.isPreETBDoor;
					}
					instance_destroy(door);
					//delete door;
				}
			}
		}
	}
}