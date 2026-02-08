disabled = false;
doHighlight = true;
inBounds = false;
if(customSprite != noone) {
	sprite_index = customSprite;
	image_xscale = 1;
	image_yscale = 1;
}
else sprite_index = x16;
Toggle = function() {
	visible = !visible;
}
depth = -10;