/*
if(run) {
	gameOverYVelo += 0.5;
	gameOverYPos += gameOverYVelo;
	image_speed = 0;
	if(gameOverYPos >= 320) {
		image_speed = 0.35;
		gameOverYPos = 320;
		playerPos[0] += 6;
		
	}
	
}
*/


if(keyboard_check(vk_anykey)) {
	o_GameManager.goToHub();
}