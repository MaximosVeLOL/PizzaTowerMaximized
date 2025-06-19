//We are not useless!

activate = function() {
	var dir = x < room_width / 2;
	with(instance_create_depth((dir ? -100 : room_width + 100), y - 15, 0, o_Le_Noise)) image_xscale = dir ? 1 : -1;
	PlaySound(sfx_noisespawn);
	Log("Release the baby!");
}