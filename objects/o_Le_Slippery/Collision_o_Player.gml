//TODO - Implement barrel cases
if(sprite_index == sprite_level_slippery) {
	instance_destroy();
	instance_create_depth(x, y, 0, o_P_DeadEnemy, {sprite_index : sprite_index});
}
if(other.state != "barrel") {
	other.setState("slip");
	other.movespeed = 8;
	CreateEffect({x : other.x, y : other.y, sprite_index : sprite_effect_dashcloud });
}
else {
	other.tempVar[0] = 2;
	other.sprite_index = spr_player_barrel_rollS;
	other.mask_index = spr_player_mask_crouch;
}