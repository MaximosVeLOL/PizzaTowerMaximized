event_inherited();

triggered = false;

Input = function(reason) {
	switch(type) {
		case 0: //Multiple
		
		break;
		
		case 1: //Once
			if(triggered)
				return;
			triggered = true;
		break;
		
		case 2:
		
		break;
	}
	Output(GetTarget(), reason);
}