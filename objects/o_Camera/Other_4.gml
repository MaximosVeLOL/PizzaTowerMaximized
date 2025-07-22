//room_set_viewport, and camera_create_view do not work with the current room, so I have to do this.

view_enabled = true;
room_persistent = true;

ForEachPlayer(function(p, index) {
	var MAX = instance_exists(o_MultiplayerSystem) ? o_MultiplayerSystem.maxPlayers : 1;
	delete p;
	view_visible[index] = true;
	view_wport[index] = 960;
	view_hport[index] = 540 / MAX;
	view_yport[index] = (540/MAX) * index;

	camera_set_view_size(view_camera[index],  960, 540);
});