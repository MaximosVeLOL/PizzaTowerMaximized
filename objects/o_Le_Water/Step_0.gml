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
			if(pushDir != 0) {
				o_Player.setState("transition");
				o_Player.xscale = -pushDir;
				o_Player.x += 15 * pushDir;
				if(!place_meeting(o_Player.x, o_Player.y + 1, o_C_Parent)) {
					o_Player.y++;
				}
			}
		}
	}
}
else if(pushDir != 0 && o_Player.state == "transition") o_Player.setState("normal");