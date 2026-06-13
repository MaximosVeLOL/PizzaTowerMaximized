with(o_Player) {
	other.x = x;
	other.y = y;
	if(state != PlayerState.Mach3 && state != PlayerState.SuperSlam) instance_destroy(other);
}