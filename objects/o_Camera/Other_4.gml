//room_set_viewport, and camera_create_view do not work with the current room, so I have to do this.

view_enabled = true;
room_persistent = true;
ForEachPlayer(function(p, index) {
	delete p;
	view_visible[index] = true;
	view_wport[index] = 960;
	view_hport[index] = 540 / index;
	view_yport[index] = 0;

	camera_set_view_size(view_camera[index],  960, 540);
});