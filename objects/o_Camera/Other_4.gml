//room_set_viewport, and camera_create_view do not work with the current room, so I have to do this.

view_enabled = true;
view_visible[0] = true;
view_wport[0] = o_GameManager.getScreenSize()[0];
view_hport[0] = o_GameManager.getScreenSize()[1];
room_persistent = true;

camera_set_view_size(view_camera[0],  o_GameManager.getScreenSize()[0], o_GameManager.getScreenSize()[1]);
if(global.settings.gameplaySettings.twoPlayerEnabled) {
	view_hport[0] = o_GameManager.getScreenSize()[0]/2;
	//camera_set_view_o_GameManager.getScreenSize()(view_camera[0], 960,270);
	if(false) { //Strech camera
		camera_set_view_size(view_camera[1], o_GameManager.getScreenSize()[0], o_GameManager.getScreenSize()[1]);
		view_hport[0] = o_GameManager.getScreenSize()[1]/2;
		
		view_hport[1] = o_GameManager.getScreenSize()[1]/2;
		view_yport[1] = o_GameManager.getScreenSize()[1]/2;
		view_wport[1] = o_GameManager.getScreenSize()[0];
	}
	else {
		camera_set_view_size(view_camera[0], 960, 540);
		camera_set_view_size(view_camera[1], 960, 540);
		view_wport[1] = 960;
		view_hport[1] = 540;
		view_yport[1] = 540;
		
	}
	view_visible[1] = true;
}