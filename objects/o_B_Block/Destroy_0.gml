if(image_xscale != 2) {
CreateParticle(x - 16,y - 16,o_P_Breakable, {sprite_index : brokenSprite});
CreateParticle(x + 16,y - 16,o_P_Breakable, {sprite_index : brokenSprite});
CreateParticle(x - 16,y + 16,o_P_Breakable, {sprite_index : brokenSprite});
CreateParticle(x + 16,y + 16,o_P_Breakable, {sprite_index : brokenSprite});
}
else {
	CreateParticle(x - 32,y - 32,o_P_Breakable, {sprite_index : brokenSprite});
	CreateParticle(x + 32,y - 32,o_P_Breakable, {sprite_index : brokenSprite});
	CreateParticle(x - 32,y + 32,o_P_Breakable, {sprite_index : brokenSprite});
	CreateParticle(x + 32,y + 32,o_P_Breakable, {sprite_index : brokenSprite});
}
tilemap_set_at_pixel(layer_tilemap_get_id("FG"), 0, x, y );
PlaySound(sfx_break, false, false, true);
