event_inherited();
reqStatesX = ["mach2", "mach3", "machroll", "machfreefall"];
reqStatesBottom = ["jump", "mach2", "mach3", "machfreefall", "superJump", "highJump", "knight"];
reqStatesTop = ["freefall", "superslam", "knight"];
brokenSprite = spr_breakable_broken; //So many children, so we do this.
if(sprite_index == spr_glassblock) brokenSprite = spr_breakable_broken;

onTopBreak = function(plr) {
	with(plr) {
		if(state == "freefall" && tempVar[0] == 0) {
			animVar = true;
			image_index = 0;
			image_speed = 1;
			velocity.y = -7;
			tempVar[0] = 0;
			tempVar[1] = 0;
		}
	}
}
onXBreak = function(plr) {
	with(plr) {
		if(state == "barrel" && tempVar[0] == 2) {
			instance_destroy(other);
		}
		else if(state == "slip" && movespeed > 6) {
			instance_destroy(other);
		}
	}
}
onBottomBreak = function(plr) {
	with(plr) {
		if(state == "jump" && velocity.y < 0) velocity.y = 1;
	}
}
if(image_xscale == 2) {
	sprite_index = asset_get_index(sprite_get_name(sprite_index) + "_big");
	image_xscale = 1;
	image_yscale = 1;
}