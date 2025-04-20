//LogError(string(asset_get_index(sprite_get_name(sprite_index) + "_broken")) + "\n" + sprite_get_name(sprite_index) + "_broken");
instance_create_depth(x + 8,y - 8, 0, o_P_Breakable, {sprite_index : asset_get_index(sprite_get_name(sprite_index) + "_broken")});
instance_create_depth(x - 8,y - 8, 0, o_P_Breakable, {sprite_index : asset_get_index(sprite_get_name(sprite_index) + "_broken")});
instance_create_depth(x + 8,y + 8, 0, o_P_Breakable, {sprite_index : asset_get_index(sprite_get_name(sprite_index) + "_broken")});
instance_create_depth(x - 8,y + 8, 0, o_P_Breakable, {sprite_index : asset_get_index(sprite_get_name(sprite_index) + "_broken")});
var _layer = layer_tilemap_get_id(layer_get_id("FG"));
var _tile = tilemap_get_at_pixel(_layer,x,y);
if(layer_tilemap_exists(layer_get_id("FG"), _layer) && _tile != -1) layer_tilemap_destroy(_tile);
if(place_meeting(x,y-33, o_B_Parent)) {
	instance_destroy(instance_place(x,y-33,o_B_Parent));
	return;
}
if(place_meeting(x,y+33, o_B_Parent)) instance_destroy(instance_place(x,y+33,o_B_Parent));