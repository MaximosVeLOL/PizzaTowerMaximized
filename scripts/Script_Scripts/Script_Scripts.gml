function PlaySound(snd, override = false, loop = false) {
	if(audio_is_playing(snd) && !override || global.settings.audioSettings.muteAll || loop && global.settings.audioSettings.muteMusic || !loop && global.settings.audioSettings.muteSfx) {
		return;
	}
	return audio_play_sound(snd, 999, loop);
}

function ShakeScreen(mag) {
	o_Camera.shakeMag = mag;
}
function LogError(_message, crashGame = false) {
	if(!crashGame) show_message("From " + object_get_name(object_index) + ":\n" + _message + "\n\nDebugInfo:\nObject ID: " + string(id) + ", Room: " + room_get_name(room));
	if(crashGame) throw("LogError Crash Script Message:\n" + _message);
}
function RoomGoto(rm, newPos = [0,0], newState = "") {
		room_goto(rm);
		if(newState != 0) o_GameManager.setState(newState);
		obj_player.x = newPos[0];
		obj_player.y = newPos[1];
}
function GetDebugSettings() {
	if(!instance_exists(o_DEBUG_Console)) return false;
	return o_DEBUG_Console.settings;
}
function GetNearestPlayer() {
	return obj_player;
}
function GetInput(reqKey, inputType = 0) {
	var s = variable_struct_get(global.settings.keyBinds, "p1");
	//show_message(s);
	switch(inputType) {
		case 0:
			return keyboard_check(variable_struct_get(s, reqKey));
		break;
		
		case 1:
			return keyboard_check_pressed(variable_struct_get(s, reqKey));
		break;
		
		case 2:
			return keyboard_check_released(variable_struct_get(s, reqKey));
		break;
	}
	throw("Que?");
}
function CollideAndMove(mass, maxYVelocity) {
	velocity[1] += mass;
	velocity[1] = clamp(velocity[1], -maxYVelocity, maxYVelocity);
	if(place_meeting(x + velocity[0], y, o_C_Parent)) {
		if(!place_meeting(x + velocity[0], y - (abs(velocity[0]) + 1), o_C_Parent ) ) while(place_meeting(x + velocity[0], y, o_C_Parent)) y--;
		if(place_meeting(x + velocity[0], y, o_C_Parent)) { //If we are still touching
			while(!place_meeting(x + sign(velocity[0]), y, o_C_Parent)) {
				x += sign(velocity[0]);
			}
			velocity[0] = 0;
		}
	}
	if(place_meeting(x + velocity[0], y + velocity[1], o_C_Parent)) {
		while(!place_meeting(x + velocity[0], y + sign(velocity[1]), o_C_Parent)) {
			y += sign(velocity[1]);
		}
		velocity[1] = 0;
	}
	x += velocity[0];
	y += velocity[1];
}