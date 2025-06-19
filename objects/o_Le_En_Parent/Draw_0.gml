draw_self();
if(GetDebugSettings().renderDebugText) { 
	draw_set_font(asset_font);
	draw_text(x,bbox_top - 200, "State: " + state + "\nVelocity: " + string(velocity[0]) + ", " + string(velocity[1]) + "\nSpeed: " + string(movespeed) + "\nTempVar: " + string(tempVar[0]) + ", " + string(tempVar[1]) + ", " + string(tempVar[2]) + "\nSprite Data: sprInd: " + sprite_get_name(sprite_index) + ", imgInd: " + string(image_index) + ", imgNum: " + string(image_number) + ", imgSpd: " + string(image_speed));
	GUI_RESET;
}