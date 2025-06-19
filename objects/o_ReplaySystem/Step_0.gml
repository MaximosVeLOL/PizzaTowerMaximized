if(mode == "replay") {
	if(inputIndex > 0) keyboard_key_release(inputs[inputIndex - 1]);
	if(inputIndex >= array_length(inputs)) {
		instance_destroy();
		LogError("Done!");
		return;
	}
	if(inputs[inputIndex] != vk_nokey && inputs[inputIndex] != vk_enter && inputs[inputIndex] != vk_escape) keyboard_key_press(inputs[inputIndex]);
	inputIndex++;
}
else {
	array_push(inputs, keyboard_key);
	if(keyboard_check_pressed(vk_f1)) {
		LogError("Record done, going to replay");
		mode = "replay";
		room_restart();
	}
}