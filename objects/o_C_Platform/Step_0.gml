
//var check = false;
ForEachPlayer(function(player) {
	if(player.bbox_right >= bbox_left && player.bbox_left <= bbox_right && player.bbox_bottom <= bbox_top && !place_meeting(x,y,o_C_Wall)) {
		instance_create_depth(x,y,0,o_C_Wall, {image_xscale : self.image_xscale});
	}
	else instance_destroy(instance_place(x,y,o_C_Wall));
});