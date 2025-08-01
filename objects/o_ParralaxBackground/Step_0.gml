for(i = 0 ; i < array_length(backgrounds);i++) {
	layer_x(backgrounds[i].layerID, lerp(0, room_width - 960, camera_get_view_x(view_camera[0]) / (room_width - 960)) / backgrounds[i].depth );
	layer_background_xscale(backgrounds[i].layerID, backgrounds[i].scale);
	//layer_script_begin(backgrounds[i].layerID, ) Could we just use this??
}