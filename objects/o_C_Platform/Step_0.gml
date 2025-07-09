/*
var child = instance_place(x,y,o_C_Wall);
var check = false;
for(var i = 0 ; i < instance_number(o_PlayerParent);i++) {
	if(instance_find(o_PlayerParent, i).bbox_right > bbox_left && instance_find(o_PlayerParent, i).bbox_left < bbox_right && instance_find(o_PlayerParent, i).bbox_bottom < bbox_top + 1) {
		if(child == noone) instance_create_depth(x,y,0,o_C_Wall, {image_xscale : self.image_xscale});
		break;
	}
	else if(child != noone) instance_destroy(child);
}