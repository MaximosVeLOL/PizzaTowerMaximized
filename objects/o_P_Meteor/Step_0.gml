with(o_PlayerParent) {
	other.x = x;
	other.y = y;
	if(state != "mach3" && state != "superslam") instance_destroy(other);
}