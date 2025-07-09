draw_sprite_ext(sprite_index, image_index, x,y, xscale * image_xscale, 1, 0, c_white, 1);
if(instance_exists(o_DEBUG_Console) && o_DEBUG_Console.settings.renderPlayerMask) {
	draw_sprite_ext(mask_index, 0, x,y, xscale, 1, 0, c_white, 0.5);
	draw_arrow(x,y, x + (50 * xscale), y, 25);	
}
if(stunStuff.flashing) {
	shader_set(Shader_FullBright);
	draw_self();
	//draw_sprite_ext(sprite_index, image_index, x,y, xscale * image_xscale, 1, 0, c_white, 1);
	shader_reset();
}
if(global.settings.gameplaySettings.multiplayer) draw_text(x - 20,bbox_top - 50, "P" + string(PD));