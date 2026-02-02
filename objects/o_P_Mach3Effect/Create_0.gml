owner = noone;
canMove = false;
image_blend = make_color_hsv(choose(100,255), 255,255);
image_alpha = 0.8;
if(instance_exists(o_Player)) {
    sprite_index = o_Player.sprite_index;
    image_xscale = o_Player.xscale;
}
else sprite_index = spr_player_mach3;
frames = 0;