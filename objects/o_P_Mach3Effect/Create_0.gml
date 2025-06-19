image_blend = make_color_hsv(choose(100,255), 255,255);
image_alpha = 0.8;
if(instance_exists(o_PlayerParent)) {
    sprite_index = o_PlayerParent.sprite_index;
    image_xscale = o_PlayerParent.xscale;
}
else sprite_index = spr_player_mach3;
frames = 0;