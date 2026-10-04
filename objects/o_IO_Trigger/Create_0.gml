event_inherited();

triggered = false;

Input = function(reason) {
	if(triggered) 
		return;
	triggered = true;
	switch(type) {
		case 0: //Multiple
		
		break;
		
		case 1: //Once
			instance_destroy();
		break;
		
		case 2:
		
		break;
	}
	Output(GetTarget(), reason);
}