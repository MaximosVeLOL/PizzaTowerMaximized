event_inherited();
reqStatesX = PlayerState.Mach3;
reqStatesTop = [PlayerState.SuperSlam, PlayerState.Knight];
reqStatesBottom = PlayerState.SuperJump;
onTopBreak = function(plr) {
	if(plr.state == PlayerState.Freefall && plr.tempVar[0] == 1) instance_destroy();
}
onXBreak = function(plr) {
	if(global.settings.player.moveSet == Moveset.PreETB && plr.state == PlayerState.Mach2) instance_destroy();
}
if(global.settings.player.moveSet == Moveset.PreETB) {
	sprite_index = spr_breakable;
	image_xscale = 2;
	image_yscale = 2;
}