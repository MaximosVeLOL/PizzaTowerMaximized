if(velocity.x != 0) return;
o_GameManager.level.score += 10;
instance_destroy();
instance_create_depth(x,y,0,o_P_PointText, {sprite_index : sprite_effect_points_10});
PlaySound(sfx_collect, false, false, true);