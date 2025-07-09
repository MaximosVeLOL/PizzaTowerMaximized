alpha += faded ? -0.05 : 0.05;
if(alpha == 1 && !faded) {
	if(instance_exists(o_GameManager)) o_GameManager.endLevel();
	else {
		instance_deactivate_all(true);
		instance_create_depth(0,0,0,o_UI_Rank);
	}
	instance_destroy();
}