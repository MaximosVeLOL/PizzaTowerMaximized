draw_self();
if(instance_exists(o_DEBUG_Console) && o_DEBUG_Console.settings.renderDebugText) { 
	draw_set_font(-1);
	draw_text(x,bbox_top - 200, "State: " + state + "\nVelocity: " + string(velocity.x) + ", " + string(velocity.y) + "\nSpeed: " + string(movespeed) + "\nTempVar: " + string(tempVar[0]) + ", " + string(tempVar[1]) + ", " + string(tempVar[2]) + "\nSprite Data: sprInd: " + sprite_get_name(sprite_index) + ", imgInd: " + string(image_index) + ", imgNum: " + string(image_number) + ", imgSpd: " + string(image_speed));
	GUI_RESET;
}
if(instance_exists(o_DEBUG_Console) && o_DEBUG_Console.settings.renderPlayerMask) {
	draw_sprite(mask_index, 0, x, y);
	draw_arrow(x,y, x + (50 * image_xscale), y, 25);	
}