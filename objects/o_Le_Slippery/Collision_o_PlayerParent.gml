//TODO - Implement barrel cases
instance_destroy();
instance_create_depth(x, y, 0, o_P_DeadEnemy, {sprite_index : sprite_level_slippery});
other.setState("slip");
other.movespeed = 8;