x = obj_player.x;
y = obj_player.y;
with(obj_player) {
	if(state != "mach3" && state != "superslam") instance_destroy();
}