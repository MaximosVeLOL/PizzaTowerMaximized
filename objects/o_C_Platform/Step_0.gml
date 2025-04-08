var child = instance_place(x,y,o_C_Wall);
if(GetNearestPlayer().bbox_right > bbox_left && GetNearestPlayer().bbox_left < bbox_right && GetNearestPlayer().bbox_bottom < bbox_top + 1) {
	if(child == noone) instance_create_depth(x,y,0,o_C_Wall, {image_xscale : self.image_xscale});
}
else if(child != noone) instance_destroy(child);