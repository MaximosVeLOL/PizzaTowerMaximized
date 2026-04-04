if(room == ETBRoom_TSecret1 || room == ETBRoom_TSecret2 || room == ETBRoom_T_BackRoom || room == ETBRoom_T4_Branch || room == ETBRoom_TTreasure || o_GameManager.level.index == LevelIndex.ETB_Ancient && string_digits(room_get_name(room)) > 4 || room == ETBRoom_Tutorial1) return;

for(i = 0 ; i < array_length(backgrounds);i++) {
	var currentBackground = backgrounds[i];
	//TODO - Apply this for multiplayer???
	layer_x(currentBackground.layerID, camera_get_view_x(view_camera[0]) / currentBackground.depth);
	//layer_y(currentBackground.layerID, -(camera_get_view_y(view_camera[0]) / currentBackground.depth));
	//layer_x(currentBackground.layerID, lerp(0, room_width - 1500, camera_get_view_x(view_camera[0]) / (room_width - 960)) / currentBackground.depth );
	layer_y(currentBackground.layerID, currentBackground.ogY + (lerp(0, room_height - 1000, camera_get_view_y(view_camera[0]) / (room_height - 540)) / currentBackground.depth) );
	//show_debug_message(layer_get_y(currentBackground.layerID));
	//layer_script_begin(currentBackground.layerID, ) Could we just use this??
}