if(room == endRoom) instance_destroy();
if(room == ETBRoom_TSecret1 || room == ETBRoom_TSecret2 || room == ETBRoom_T_BackRoom || room == ETBRoom_T4_Branch || room == ETBRoom_TTreasure || o_GameManager.level.index == LevelIndex.ETB_Ancient && string_digits(room_get_name(room)) > 4 || room == ETBRoom_Tutorial1) return;
//var sprite = -1;
var bgId = -1;
//show_debug_message("XSCALE & ID");
for(i = 0 ; i < array_length(backgrounds);i++) { //Scale the background once, not twice! Saves on CPU Cycles.settings..
	bgId = layer_get_id(backgrounds[i].layerName);
	backgrounds[i].layerID = layer_background_get_id(bgId);
	//show_debug_message("ID: " + string(backgrounds[i].layerID));
	backgrounds[i].ogY = room_height - (sprite_get_height(layer_background_get_sprite(backgrounds[i].layerID)) * backgrounds[i].scale);
	layer_background_xscale(backgrounds[i].layerID, backgrounds[i].scale);
	layer_background_yscale(backgrounds[i].layerID, backgrounds[i].scale);
	//show_debug_message(layer_background_get_xscale(backgrounds[i].layerID));
	//sprite = layer_background_get_sprite(backgrounds[i].layerID);
	//!!!Layer ID is changed!!!
	backgrounds[i].layerID = bgId;
	//layer_y(backgrounds[i].layerID, backgrounds[i].yOffset); //Too lazy to change all other values, so here we go!
	//layer_y(backgrounds[i].layerID, room_height - (sprite_get_height(sprite) * backgrounds[i].scale));
	show_debug_message(string(i) + ": " + string(layer_get_y(backgrounds[i].ogY)));
}
//show_debug_message("END");