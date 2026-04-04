event_inherited();
reqStatesX = "mach3";
reqStatesTop = ["superslam", "knight"];
reqStatesBottom = "superJump";
onTopBreak = function(plr) {
	if(plr.state == "freefall" && plr.tempVar[0] == 1) instance_destroy();
}
onXBreak = function(plr) {
	if(global.settings.playerSettings.moveSet == Moveset.PreETB && plr.state == "mach2") instance_destroy();
}
if(global.settings.playerSettings.moveSet == Moveset.PreETB) {
	sprite_index = spr_breakable;
	image_xscale = 2;
	image_yscale = 2;
}