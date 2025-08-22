
//var check = false;
	if(o_PlayerParent.bbox_right >= bbox_left && o_PlayerParent.bbox_left <= bbox_right && o_PlayerParent.y <= y) { //Not using bbox_bottom, because it actually causes the player to snap to the wall.
		if(child == noone) child = instance_create_depth(x,y,0,o_C_Wall, {image_xscale : self.image_xscale});
	}
	else if(child != noone) {
		instance_destroy(child);
		child = noone;
	}