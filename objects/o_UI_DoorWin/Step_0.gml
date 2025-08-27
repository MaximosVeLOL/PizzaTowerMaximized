image_xscale += 1;
image_yscale += 1;
if(image_xscale >= 60) {
	o_GameManager.endLevel(true, true);
	instance_destroy();
}