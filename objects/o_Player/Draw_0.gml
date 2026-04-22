if(global.settings.player.moveSet == Moveset.ETB && state == "mach3" && tempVar[2] > 0) { //Terrible hack!!! But this is the only way how I know how to do it.
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

if(global.settings.multiplayer.enabled) draw_text(x - 20,bbox_top - 50, "P" + string(playerID + 1));
/* from camera draw event
var data = audio_listener_get_data(0);
draw_set_color(c_green);
draw_ellipse(data[? "x"], data[? "y"], data [? "x"] + 25, data[? "y"] + 25, false);
ds_map_destroy(data);
GUI_RESET;
*/