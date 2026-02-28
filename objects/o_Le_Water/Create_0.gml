someoneOnTop = place_meeting(x, bbox_top - 1, o_Le_Water);
var someoneOnBottom = place_meeting(x, bbox_bottom + 1, o_Le_Water);
sprite_index = (someoneOnTop ? sprite_level_waterBtm : sprite_level_waterTop);

child = noone;
if(image_yscale != 1 && someoneOnBottom && !someoneOnTop) {
	y += 32;
	image_yscale--;
	
	instance_create(x, y - 32, o_Le_Water, {image_xscale : self.image_xscale});
	someoneOnTop = true;
	sprite_index = sprite_level_waterBtm;
}