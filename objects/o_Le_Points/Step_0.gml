if(!canMove) {
	if(PLAYER_GROUNDED) velocity[0] = 0;
	CollideAndMove(0.5);
}
else y += sin(10.5 * (get_timer() / 1000000));