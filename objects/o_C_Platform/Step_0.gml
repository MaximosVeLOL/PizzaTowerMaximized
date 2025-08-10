
//var check = false;
	if(o_PlayerParent.bbox_right >= bbox_left && o_PlayerParent.bbox_left <= bbox_right && o_PlayerParent.bbox_bottom <= bbox_top) {
		if(!place_meeting(x,y,o_C_Wall) ) instance_create_depth(x,y,0,o_C_Wall, {image_xscale : self.image_xscale});
	}
	else if(place_meeting(x,y,o_C_Wall)) instance_destroy(instance_place(x,y,o_C_Wall));