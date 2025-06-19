if(!instance_exists(o_PlayerParent)) return;
var _pos = [ clamp(instance_find(o_PlayerParent, 0).x - 480, 0, room_width - 960), clamp(instance_find(o_PlayerParent, 0).y - 270, 0, room_height - 540) ];
if(shakeMag != 0) {
	shakeMag -= 0.1;
	if(shakeMag <= 0) shakeMag = 0; 
	_pos = [ clamp(instance_find(o_PlayerParent, 0).x - 480, 0, room_width - 960) + random_range(-shakeMag, shakeMag), clamp(instance_find(o_PlayerParent, 0).y - 270, 0, room_height - 540) + random_range(-shakeMag, shakeMag) ];
}
camera_set_view_pos(view_camera[0], _pos[0], _pos[1]);
if(global.settings.gameplaySettings.twoPlayerEnabled) {
	_pos = [ instance_find(o_PlayerParent, 1).x - 480, instance_find(o_PlayerParent, 1).y - 270];
	if(shakeMag != 0) {
		_pos = [instance_find(o_PlayerParent, 1).x - (480 + random_range(-shakeMag, shakeMag)), instance_find(o_PlayerParent, 1).y - (270 + random_range(-shakeMag, shakeMag))];
	}
	camera_set_view_pos(view_camera[1], clamp(_pos[0], 0, room_width - 960), clamp(_pos[1], 0, room_height - 540));
}
/* Wavy background stuff
if(string_count(room_get_name(room), "Secret" ) > 0) {
	shader_set(Shader_Distort);
	var s = shader_get_uniform(Shader_Distort, "time");
	shader_set_uniform_f(s, get_timer() / 1000000)
	
}