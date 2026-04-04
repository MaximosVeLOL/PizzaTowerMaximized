if(instance_number(o_Camera) > 1) {
	Log("Extra Camera!");
	instance_destroy();
	return;
}
image_speed = 0.35;
hudVisible = true;
shake = {
	mag : 0,
	acc : 0,
};
setupRoom = function() {
	view_enabled = true;
	if(global.settings.multiplayerSettings.enabled) {
		var c = o_MultiplayerHandler.playerCount;
		// 0 - Vertical strips (implemented)
		// 1 - Split screen (implemented)
		// 2 - Whole screen (implemented)
		var h = (540/c);
		//Boom
		switch(global.settings.multiplayerSettings.cameraType) {
			case 0:

				for(var i = 0 ; i < c;i++) {
					view_visible[i] = true;
					view_wport[i] = 960;
					view_hport[i] = h;
					view_yport[i] = i * h;
					camera_set_view_size(view_camera[i], 960, h);
				}
				return;
			break;
		
			case 1:
				h = 540/2;
				var w = (960/2);
				var scaleDown = true;
				for(var i = 0 ; i < c;i++) {
					view_visible[i] = true;
					view_wport[i] = w;
					var _x = 0;
					switch(c) {
						case 2:
							view_hport[i] = 540;
							view_xport[i] = i * w;
						break;
					
						case 3:
							_x = (i == 0 ? 0 : (i == 1 ? w : w/2) );
							view_hport[i] = h;
							view_xport[i] = _x;
							view_yport[i] = (i > 1 ? h : 0);
						break;
					
						case 4:
							_x = ((i + 1) % 2 == 0 ? w : 0);
							view_hport[i] = h;
							view_xport[i] = _x;
							view_yport[i] = (i > 1 ? h : 0);
						break;
					}
					if(scaleDown) camera_set_view_size(view_camera[i], w, (c != 2 ? h : 540));
					else camera_set_view_size(view_camera[0], 960, 540);
				}
				return;
			break;
		
			case 2:
		
			break;
		}
	}
	view_visible[0] = true;
	view_wport[0] = 960;
	view_hport[0] = 540;
	view_camera[0] = camera_create_view(0, 0, 960, 540);
}

pos = new Vector();