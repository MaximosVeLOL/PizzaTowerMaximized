velocity = new Vector();
movespeed = 1.5;
mass = 0.5;
isStunned = false;
spriteBaseName = "";
tempVar = [0,0];
die = function(canMove = true) {
	instance_destroy();
	if(canMove) instance_create_depth(x,y,0,o_P_DeadEnemy, {sprite_index : spriteDead });
	else instance_create_depth(x,y,0,o_P_Effect, {sprite_index : spriteDead });
	PlaySound(sfx_enemykill);
}
spriteWalk = -1;
spriteStun = -1;
spriteDead = -1;
depth = 0;