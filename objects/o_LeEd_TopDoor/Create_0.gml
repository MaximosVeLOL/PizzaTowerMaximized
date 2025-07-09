activated = false;
canMove = false;
timer = 0;

//Settings
startOpened = false;
doorSpeed = 1;
delay = 0;
openSound = -1;
closeSound = -1;



action = function() {
	activated = !activated;
	if(openSound > -1) PlaySound(openSound, false, false, true); //This might be sketchy...
	
}