if(keyboard_check_pressed(vk_control) && global.settings.gameplay.debugEnabled) {
	active = !active;
	if(instance_exists(o_Camera)) o_Camera.hudVisible = !active;
	if(instance_exists(o_GameManager)) o_GameManager.mode = (active ? GameState.None: GameState.Game);
	keyboard_string = "";
}
for(var i = 0 ; i < array_length(binds);i++) {
	if(keyboard_check_pressed(binds[i].key)) {
		execute(binds[i].key);
	}
}
if(active) {
	if(keyboard_check_pressed(vk_enter)) execute(keyboard_string);
	if(( keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_down) )&& array_length(prevCommands) > 0) {
		keyboard_string = prevCommands[prevCommandIndex];
		prevCommandIndex -= keyboard_check_pressed(vk_up) - keyboard_check_pressed(vk_down);
		prevCommandIndex = clamp(prevCommandIndex, 0, array_length(prevCommands) - 1);
	}
}