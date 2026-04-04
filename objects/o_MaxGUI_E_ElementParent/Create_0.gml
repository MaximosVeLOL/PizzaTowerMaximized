disabled = false;
doHighlight = true;
inBounds = false;
sound = -1;
persistent = true;
if(customSprite != noone) {
	sprite_index = customSprite;
	image_xscale = 1;
	image_yscale = 1;
}
else sprite_index = x16;
Toggle = function() {
	visible = !visible;
	inBounds = false;
}
depth = -10;