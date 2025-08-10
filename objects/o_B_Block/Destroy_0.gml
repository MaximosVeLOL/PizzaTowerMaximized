if(image_xscale != 2) {
instance_create_depth(x - 16,y - 16, 0,o_P_Breakable, {sprite_index : brokenSprite});
instance_create_depth(x + 16,y - 16, 0,o_P_Breakable, {sprite_index : brokenSprite});
instance_create_depth(x - 16,y + 16, 0,o_P_Breakable, {sprite_index : brokenSprite});
instance_create_depth(x + 16,y + 16, 0,o_P_Breakable, {sprite_index : brokenSprite});
}
else {
	instance_create_depth(x - 32,y - 32, 0,o_P_Breakable, {sprite_index : brokenSprite});
	instance_create_depth(x + 32,y - 32, 0,o_P_Breakable, {sprite_index : brokenSprite});
	instance_create_depth(x - 32,y + 32, 0,o_P_Breakable, {sprite_index : brokenSprite});
	instance_create_depth(x + 32,y + 32, 0,o_P_Breakable, {sprite_index : brokenSprite});
}
tilemap_set_at_pixel(layer_tilemap_get_id("FG"), 0, x, y );
PlaySound(sfx_break, false, false, true);
