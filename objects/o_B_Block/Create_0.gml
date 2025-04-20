reqStatesX = ["mach2", "mach3", "machroll", "machfreefall"];
reqStatesBottom = ["jump", "superjump", "highJump"];
reqStatesTop = ["freefall", "superslam"];
if(image_xscale == 2) {
	sprite_index = asset_get_index(sprite_get_name(sprite_index) + "_big");
	image_xscale = 1;
	image_yscale = 1;
}