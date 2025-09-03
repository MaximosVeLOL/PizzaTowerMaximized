
		if(o_PlayerParent.bbox_right >= bbox_left && o_PlayerParent.bbox_left <= bbox_right && o_PlayerParent.bbox_bottom >= bbox_top && o_PlayerParent.bbox_top <= bbox_bottom) {
			if(gotoLevel) {
				image_index = 1; //Open sesame
				renderText = true;
				if(textToRender == "") textToRender = GetLevelInfo(targetLevel).levelName;
			}
			else if(instance_exists(o_PizzaTimeManager)) image_index = 1;
			
			with(o_PlayerParent) { // Door opening code
				if(PLAYER_GROUNDED && GetInput("up", 1) && string_count("mach", state) == 0 && state != "door") {
					if(!other.gotoLevel && !instance_exists(o_PizzaTimeManager)) return; //One false can ruin it all
					setState("door");
				}
				if(round(image_index) == image_number && state == "door" && tempVar[0] == 0) { //On image complete
					if(instance_exists(o_GameManager)) {
						if(other.gotoLevel){
							if(!instance_exists(o_UI_DoorTrans) ) {
								o_GameManager.startLevel(other.targetLevel);
							}
						}
						else if(instance_exists(o_PizzaTimeManager)) o_GameManager.endLevel(true);
					}
					else {
						var LevelData = GetLevelInfo(levelIndex);
						room_goto(LevelData.targetRoom);
						o_PlayerParent.tempVar[0] = 1;
						o_PlayerParent.x = LevelData.newPos[0];
						o_PlayerParent.y = LevelData.newPos[1];
						if(instance_exists(o_MusicManager)) o_MusicManager.playNewSong(LevelData.newSong, LevelData.loopData);
					}
				}
			}
		}
		else {
			image_index = 0; //Hey Tim, i'd like to see Mr. Bigweld!
			renderText = false;
		}