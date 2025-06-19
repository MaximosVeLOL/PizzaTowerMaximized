alpha += faded ? -0.05 : 0.05;
if(alpha == 1 && !faded) {
	o_GameManager.endLevel();
	instance_destroy();
}