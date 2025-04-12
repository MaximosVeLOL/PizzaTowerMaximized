ShakeScreen(10);
instance_create_depth(x - 16, y - 16, 0, o_P_Breakable, {sprite_index : spr_metalblock_broken});
instance_create_depth(x + 16, y - 16, 0, o_P_Breakable, {sprite_index : spr_metalblock_broken});
instance_create_depth(x - 16, y + 16, 0, o_P_Breakable, {sprite_index : spr_metalblock_broken});
instance_create_depth(x + 16, y + 16, 0, o_P_Breakable, {sprite_index : spr_metalblock_broken});