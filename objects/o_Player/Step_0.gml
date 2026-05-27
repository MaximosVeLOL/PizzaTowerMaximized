//if(global.settings.multiplayer.enabled && playerID == -1) throw("I have ID -1!");
/*
if(velocity.x != 0 || velocity.y != 0) {
	audio_listener_position(room_width - x, y, depth);
	audio_listener_velocity(velocity.x, velocity.y, 0);
	//audio_listener_orientation(x, y, 0, 0, 0, 0);
}
*/
if(keyboard_check_pressed(vk_tab)) state = (state != PlayerState.Noclip ? PlayerState.Noclip : PlayerState.Normal);
//HandlePlayer(global.settings.player.moveSet);
moveX = GetInput("right", 0, playerID) - GetInput("left", 0, playerID);
moveY = GetInput("down", 0, playerID) - GetInput("up", 0, playerID);
with(id) {
	var ret = stateFunctions[state]();
	if(ret != undefined) continue;
	if(stunStuff.invincibleFrames > 0 && state != "hurt") {
		stunStuff.flashing = !stunStuff.flashing;
		stunStuff.invincibleFrames--;
	}
	if(xscale != 1 && xscale != -1) show_message("Scale not in range! \n" + state);
	CollideAndMove(mass, 30, true);
}