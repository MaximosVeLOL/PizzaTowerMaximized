event_inherited();
mass = 0.5;
cigarObject = (isCigarMan ? instance_create(x, y, o_H_Cigar) : noone);
cigarSprites = [
	sprite_enemy_sausageman_cigar_idle,
    sprite_enemy_sausageman_cigar_turn,
    NULL,
    NULL,
    sprite_enemy_sausageman_cigar_walk,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
];
//All enemy sprites are already defaulted to the sausageman
mask_index = spr_player_mask;
setState = function(newState, overTemp = true) {
    if(typeof(newState) == "string") throw("(setState) Expected enum, got string (" + newState + ")");
	state = newState;
	image_index = 0;
	image_speed = 1;
	if(overTemp)
		tempVar = [0, 0];
	if(state == EnemyState.Land || state == EnemyState.Idle && velocity.y > 0 || state == EnemyState.Turn || state == EnemyState.Walk || state == EnemyState.Idle)
		instance_activate_object(cigarObject);
	else instance_deactivate_object(cigarObject);
	animVar = false;
	curMass = mass;
}