event_inherited();
reqStatesX = "mach3";
reqStatesTop = ["superslam", "knight"];
reqStatesBottom = "superJump";
onTopBreak = function() {
	if(o_Player.state == "freefall" && o_Player.tempVar[0] == 1) instance_destroy();
}
onXBreak = function() {
	if(global.settings.playerSettings.moveSet == Moveset.PreETB && o_Player.state == "mach2") instance_destroy();
}
if(global.settings.playerSettings.moveSet == Moveset.PreETB) {
	sprite_index = spr_breakable;
	image_xscale = 2;
	image_yscale = 2;
}