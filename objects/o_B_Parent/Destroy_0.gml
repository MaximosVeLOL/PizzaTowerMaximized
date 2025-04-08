//LogError(string(asset_get_index(sprite_get_name(sprite_index) + "_broken")) + "\n" + sprite_get_name(sprite_index) + "_broken");
instance_create_depth(x + 8,y - 8, 0, o_P_Breakable, {sprite_index : asset_get_index(sprite_get_name(sprite_index) + "_broken")});
instance_create_depth(x - 8,y - 8, 0, o_P_Breakable, {sprite_index : asset_get_index(sprite_get_name(sprite_index) + "_broken")});
instance_create_depth(x + 8,y + 8, 0, o_P_Breakable, {sprite_index : asset_get_index(sprite_get_name(sprite_index) + "_broken")});
instance_create_depth(x - 8,y + 8, 0, o_P_Breakable, {sprite_index : asset_get_index(sprite_get_name(sprite_index) + "_broken")});