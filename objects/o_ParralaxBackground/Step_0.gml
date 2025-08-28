if(string_count("Secret", room_get_name(room) ) > 0 || room == ETBRoom_T_BackRoom) return;

for(i = 0 ; i < array_length(backgrounds);i++) {
	var currentBackground = backgrounds[i];
	layer_x(currentBackground.layerID, lerp(0, room_width - 960, camera_get_view_x(view_camera[0]) / (room_width - 960)) / currentBackground.depth );
	//show_debug_message(layer_get_x(currentBackground.layerID));
	//layer_script_begin(currentBackground.layerID, ) Could we just use this??
}