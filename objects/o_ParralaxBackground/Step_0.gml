if(string_count("Secret", room_get_name(room) ) > 0 || room == ETBRoom_T_BackRoom) return;

for(i = 0 ; i < array_length(backgrounds);i++) {
	var currentBackground = backgrounds[i];
	//TODO - Apply this for multiplayer???
	layer_x(currentBackground.layerID, camera_get_view_x(view_camera[0]) / currentBackground.depth);
	//layer_y(currentBackground.layerID, camera_get_view_y(view_camera[0]) / currentBackground.depth);
	//layer_x(currentBackground.layerID, lerp(0, room_width - 960, camera_get_view_x(view_camera[0]) / (room_width - 960)) / currentBackground.depth );
	//layer_y(currentBackground.layerID, lerp(0, room_height - 540, camera_get_view_y(view_camera[0]) / (room_height - 540)) / currentBackground.depth );
	//show_debug_message(layer_get_y(currentBackground.layerID));
	//layer_script_begin(currentBackground.layerID, ) Could we just use this??
}