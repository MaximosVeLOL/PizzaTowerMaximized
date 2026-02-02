if(canMove) {
	if(PLAYER_GROUNDED) velocity.x = 0;
	CollideAndMove(0.5);
}
else offset += sin(10.5 * (get_timer() / 1000000));