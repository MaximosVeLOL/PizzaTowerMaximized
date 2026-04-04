if(other.velocity.y >= 0) {
	other.setState("barrel");
	PlaySound(sound_splash, true);
	other.tempVar[0] = 3;
	other.x = x;
	other.y = y;
	instance_destroy();
}