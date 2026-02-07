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
pos = new Vector();