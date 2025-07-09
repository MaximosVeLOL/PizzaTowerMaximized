	ForEachPlayer(function(targetPlayer) {
		if(targetPlayer.bbox_right >= bbox_left && targetPlayer.bbox_left <= bbox_right && targetPlayer.bbox_bottom >= bbox_top && targetPlayer.bbox_top <= bbox_bottom) {
			if(gotoLevel) {
				image_index = 1; //Open sesame
				renderText = true;
			}
			with(targetPlayer) {
				if(PLAYER_GROUNDED && GetInput("up", 1, PD) && string_count("mach", state) == 0 && state != "door") {
					if(!other.gotoLevel && !instance_exists(o_PizzaTimeManager)) return; //One false can ruin it all
					setState("door");
				}
				if(round(image_index) == image_number && state == "door" && tempVar[0] == 0) {
					if(instance_exists(o_GameManager)) {
						if(other.gotoLevel){
							if(!instance_exists(o_UI_DoorTrans) ) {
								o_GameManager.startLevel(other.targetRoom, other.newPos, other.newSong, other.loopData);
							}
						}
						else if(instance_exists(o_PizzaTimeManager)) o_GameManager.endLevel();
					}
					else {
						if(!other.gotoLevel) instance_create_depth(0,0,0,o_UI_LevelEnd); // ???
						else {
							room_goto(other.targetRoom);
							o_PlayerParent.tempVar[0] = 1;
							o_PlayerParent.x = other.newPos[0];
							o_PlayerParent.y = other.newPos[1];
							if(instance_exists(o_MusicManager)) o_MusicManager.playNewSong(other.newSong, other.loopData);
						}
					}
				}
			}
		}
		else {
			image_index = 0; //Hey Tim, i'd like to see Mr. Bigweld!
			renderText = false;
		}
	});