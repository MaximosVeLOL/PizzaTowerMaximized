//room_set_viewport, and camera_create_view do not work with the current room, so I have to do this.

view_enabled = true;
view_visible[0] = true;
view_wport[0] = 960;
view_hport[0] = 540;
camera_set_view_size(view_camera[0], 960, 540);
if(global.settings.gameplaySettings.twoPlayerEnabled) {
	camera_set_view_size(view_camera[0], 960, 270);
	view_yport[0] = 270
	view_hport[0] = 270;
	
	view_visible[1] = true;
	view_wport[1] = 960;
	view_hport[1] = 270;
	camera_set_view_size(view_camera[1], 960, 270);
}