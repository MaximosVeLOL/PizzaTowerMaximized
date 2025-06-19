score += 100;
instance_destroy();
instance_create_depth(x,y,0,o_P_PointText, {sprite_index : sprite_effect_points_100});
PlaySound(sfx_bigcollect, false, false, true);