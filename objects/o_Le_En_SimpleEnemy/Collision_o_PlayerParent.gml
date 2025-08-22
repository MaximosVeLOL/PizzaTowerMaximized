if(other.state != "hurt" && other.state != "tackle") { //Hump hump hump!
	if(state != "stun") {
		if(other.state == "jump" && other.velocity[1] > 0) {
			other.velocity[1] = -7;
			other.tempVar[1] = true;
			PlaySound(sfx_boing);
			return;
		}
		
		var newV = image_xscale * -3;
		image_xscale *= -1;
		velocity = [newV, -3];
		other.velocity = [newV, -3];
		state = "stun";
		tempVar[0] = (other.state != "mach3" && other.state != "mach2");
		other.setState("bump");
		PlaySound(sfx_bump);
		
	}
	else if(other.state == "mach3" || other.state == "mach2") {
		die();
	}
}