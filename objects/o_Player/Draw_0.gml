if(global.settings.playerSettings.moveSet == Moveset.ETB && state == "mach3" && tempVar[2] > 0) { //Terrible hack!!! But this is the only way how I know how to do it.
	shader_set(Shader_Fullbright);
	draw_sprite_ext(sprite_index, image_index, x,y, xscale, 1, 0, c_white, image_alpha);
	shader_reset();
}
else if(!stunStuff.flashing)
	draw_sprite_ext(sprite_index, image_index, x,y, xscale, 1, 0, c_white, image_alpha);
if(instance_exists(o_DEBUG_Console) && o_DEBUG_Console.settings.renderPlayerMask) {
	draw_sprite_ext(mask_index, 0, x,y, xscale, 1, 0, c_white, 0.5);
	draw_arrow(x,y, x + (50 * xscale), y, 25);	
}

if(global.settings.gameplaySettings.multiplayer) draw_text(x - 20,bbox_top - 50, "P" + string(playerID));