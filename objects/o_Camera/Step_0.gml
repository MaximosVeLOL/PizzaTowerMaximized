if(!instance_exists(obj_player)) return;
var _pos = [ target.x - 480, target.y - 270];
if(shakeMag != 0) {
	shakeMag -= 0.05;
	if(shakeMag <= 0) shakeMag = 0; 
	_pos = [target.x - (480 + random_range(-shakeMag, shakeMag)), target.y - (270 + random_range(-shakeMag, shakeMag))];
}
camera_set_view_pos(view_camera[0], clamp(_pos[0], 0, room_width - 960), clamp(_pos[1], 0, room_height - 540));
if(o_GameManager.twoPlayerEnabled) {
	_pos = [ target.x - 480, target.y - 270];
	if(shakeMag != 0) {
		shakeTime -= (1/game_get_speed(gamespeed_fps));
		if(shakeTime <= 0) shakeMag = 0; 
		_pos = [target.x - (480 + random_range(-shakeMag, shakeMag)), target.y - (270 + random_range(-shakeMag, shakeMag))];
	}
	camera_set_view_pos(view_camera[1], clamp(_pos[0], 0, room_width - 960), clamp(_pos[1], 0, room_height - 540));
}