//var plrInFront = false;
plrInFront = false;
ForEachPlayer(function(i, plr) {
		if(plr.bbox_right >= bbox_left && plr.bbox_left <= bbox_right && plr.bbox_bottom >= bbox_top && plr.bbox_top <= bbox_bottom) {
			if(gotoLevel) {
				plrInFront = true;
				image_index = 1; //Open sesame
				renderText = true;
			}
			else if(instance_exists(o_PizzaTimeManager)) image_index = 1;
			
			with(plr) { // Door opening code
				if(PLAYER_GROUNDED && GetInput("up", I_WENTDOWN, playerID) && !PlayerIsMachState(state) && state != PlayerState.Door) {
					if(!other.gotoLevel && !instance_exists(o_PizzaTimeManager)) return; //One false can ruin it all
					//With all players
					o_Player.x = other.x;
					o_Player.y = plr.y;
					o_Player.setState(PlayerState.Door);
					//o_Camera.setupLevelTransition();
				}
				if(IMAGE_COMPLETE && state == PlayerState.Door && tempVar[0] == 0) { //On image complete
                    if(other.gotoLevel) {
                        if(!instance_exists(o_UI_DoorTrans) ) {
                            o_GameManager.startLevel(other.targetLevel);
                        }
                    }
                    else if(instance_exists(o_PizzaTimeManager)) {
                        //o_GameManager.endLevel(true);
                        instance_create_depth(0, 0, 0, o_UI_LevelEnd);
                    }

				}
			}
		}
		else if(!plrInFront) {
			image_index = 0; //Hey Tim, i'd like to see Mr. Bigweld!
			renderText = false;
		}
});