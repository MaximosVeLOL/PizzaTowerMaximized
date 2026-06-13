event_inherited();
if(!thrown && other.state != PlayerState.Bomb && (state == EnemyState.Walk || state == EnemyState.Idle || state == EnemyState.Turn)) {
	setState(EnemyState.Custom);
	image_xscale = other.xscale;
}