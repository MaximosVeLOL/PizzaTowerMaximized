if(instance_number(object_index) > 1) {
	Log("Extra Camera!");
	instance_destroy();
	return;
}
image_speed = 0.35;
hudVisible = true;
shake = {
	mag : 0,
	acc : 0,
}