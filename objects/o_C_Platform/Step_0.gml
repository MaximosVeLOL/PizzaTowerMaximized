
//var check = false;
	if(o_Player.bbox_right >= bbox_left && o_Player.bbox_left <= bbox_right && o_Player.bbox_bottom <= bbox_top) {
		if(child == noone) child = instance_create_depth(x,y,0,o_C_Wall, {image_xscale : self.image_xscale});
		return;
	}
	else if(child != noone) {
		instance_destroy(child);
		child = noone;
	}