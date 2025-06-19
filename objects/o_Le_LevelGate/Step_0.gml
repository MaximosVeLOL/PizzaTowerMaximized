if(instance_exists(o_PizzaTimeManager)) image_index = 1;
o_MultiplayerSystem.forEachPlayer(function(targetPlayer) {
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
				if(!instance_exists(o_UI_DoorTrans) && other.gotoLevel) o_GameManager.startLevel(other.targetRoom, other.newPos, other.newSong, other.loopData);
				if(!other.gotoLevel && instance_exists(o_PizzaTimeManager)) o_GameManager.endLevel();
			}
		}
	}
	else {
		image_index = 0; //Hey Tim, i'd like to see Mr. Bigweld!
		renderText = false;
	}
});