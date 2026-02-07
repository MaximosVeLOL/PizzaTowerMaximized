
//var check = false;
var cur = noone;
for(var i = 0 ; i < instance_number(o_Player);i++) {
	cur = instance_find(o_Player, i);
	if(cur.bbox_right >= bbox_left && cur.bbox_left <= bbox_right && cur.bbox_bottom <= bbox_top) {
		if(child == noone) child = instance_create_depth(x,y,0,o_C_Wall, {image_xscale : self.image_xscale});
		break;
	}
	else if(child != noone) {
		instance_destroy(child);
		child = noone;
	}
}