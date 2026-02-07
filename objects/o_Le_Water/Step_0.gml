if(o_Player.bbox_right >= bbox_left && o_Player.bbox_left <= bbox_right) {
	if(isTop) {
		if(o_Player.bbox_bottom <= bbox_top && (o_Player.state == "mach2" || o_Player.state == "mach3") ) {
			if(child == noone) child = instance_create_depth(x, y, 0, o_C_Wall, {image_xscale : self.image_xscale, image_yscale : self.image_yscale});
		}
		else {
			instance_destroy(child);
			child = noone;
		}
	}
	else {
		if(o_Player.bbox_top >= bbox_top + 1) {
			o_Player.mass = 0.25;
		}
	}
}