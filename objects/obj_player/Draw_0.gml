if(sprite_index <= 0) sprite_index = sprite_test;
draw_sprite_ext(sprite_index, image_index, x,y, xscale, 1, 0, c_white, 1);
draw_arrow(x,y, x + (50 * xscale), y, 25);
if(GetDebugSettings().renderPlayerMask) draw_sprite_ext(mask_index, 0, x,y, xscale, 1, 0, c_white, 0.5);
