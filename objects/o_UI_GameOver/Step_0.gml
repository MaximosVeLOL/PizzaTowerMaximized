
if(run) {
	image_speed = 0;
	gameOverYPos += 10;
	if(gameOverYPos >= 270) {
		image_speed = 0.35;
		gameOverYPos = 270;
		
		switch(tempVar) {
			case 0:
				playerPos[1] -= 2;
				playerPos[0] += 4;
				if(playerPos[1] <= 200) tempVar = 1; 
			break;
			
			case 1:
				playerPos[0] += 2;
				playerPos[1] += 2;
				if(playerPos[1] >= 540) {
					audio_stop_sound(s);
					o_GameManager.goToHub();
				}
			break;
		}
	}
	
}



if(keyboard_check(vk_anykey)) {
	audio_stop_sound(s);
	o_GameManager.goToHub();
}