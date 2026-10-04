disabled = false;
doHighlight = true;
inBounds = false;
sound = -1;
if(string_last_pos("_editor_", sprite_get_name(sprite_index)) > 0) sprite_index = x16;
//persistent = true;
/*
if(customSprite != noone) {
	sprite_index = customSprite;
	image_xscale = 1;
	image_yscale = 1;
}
else sprite_index = x16;
*/
//Children have other sprites so they can be distinguised easily, so do this
//MarkDebugCode("sprite_index = x16;");
//sprite_index = x16;


Toggle = function() {
	visible = !visible;
	inBounds = false;
}
depth = -10;