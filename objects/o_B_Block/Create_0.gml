event_inherited();
reqStatesX = ["mach2", "mach3", "machroll", "machfreefall"];
reqStatesBottom = ["jump", "mach2", "mach3", "superJump", "highJump", "knight"];
reqStatesTop = ["freefall", "superslam", "knight"];
brokenSprite = spr_breakable_broken; //So many children, so we do this.
onTopBreak = function() {
	with(o_PlayerParent) {
		if(state == "freefall") {
			animVar = true;
			velocity[1] = -7;
			tempVar[0] = 0;
			tempVar[1] = 0;
		}
	}
}
onBottomBreak = function() {
	with(o_PlayerParent) {
		if(state == "jump" && velocity[1] < 0) velocity[1] = 1;
	}
}
if(image_xscale == 2) {
	sprite_index = asset_get_index(sprite_get_name(sprite_index) + "_big");
	image_xscale = 1;
	image_yscale = 1;
}