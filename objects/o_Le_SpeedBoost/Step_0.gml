with(obj_player) {
	if(bbox_right >= other.bbox_left && bbox_left <= other.bbox_right && bbox_bottom >= other.bbox_top && bbox_top <= other.bbox_bottom) {
		xscale = other.image_xscale;
		if(obj_player.state != "mach3" && obj_player.state != "mach4" && !other.collided) {
			setState("mach3");
			tempVar[0] = 100;
			other.collided = true;
		}
		else obj_player.movespeed += 4;
	}
	else other.collided = false;
}