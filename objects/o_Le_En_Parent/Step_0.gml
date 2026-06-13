with(id) {
	var f = global.game.states.enem[state];
	var ret = f();
	if(ret != undefined) return;
}
if(dropPoints && (pointCount > 0 || global.settings.gameplay.goonerMode)) {
	pointCount--;
	with(instance_create_depth(x,y,0,o_Le_Points)) {
		canMove = true;
		velocity.x = other.image_xscale * random_range(3, 5 );
		velocity.y = random_range(-3, -10);
	}
}
CollideAndMove(curMass, 20, (state != EnemyState.Fly));