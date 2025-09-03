if(!instance_exists(o_PlayerParent)) return;

var _pos = [ clamp(o_PlayerParent.x - 480, 0, room_width - 960), clamp(o_PlayerParent.y - 270, 0, room_height - 540) ];
if(shake.mag > 0) {
	shake.mag -= shake.acc; 
	//if(shake.mag < 0) shake.mag = 0; M_OPTI - This is useless, because we don't apply the shake mag when its never above 0!
	_pos[0] += random_range(-shake.mag, shake.mag);
	_pos[1] += random_range(-shake.mag, shake.mag);
}
camera_set_view_pos(view_camera[0], _pos[0], _pos[1]);
/* Whoops
if(string_count("Secret", room_get_name(room) ) > 0) {
	shader_set(Shader_Distort);
	var s = shader_get_uniform(Shader_Distort, "time");
	shader_set_uniform_f(s, get_timer() / 1000000)
	
}