if(other.state != "hurt" && other.state != "tackle") { //Hump hump hump!
	if(state != "stun") {
		if(other.state == "mach3") {
			state = "bump";
		}
		
		var newV = image_xscale * -3;
		image_xscale *= -1;
		velocity = [newV, -3];
		other.velocity = [newV, -3];
		
		state = "stun";
		tempVar[0] = true;
		other.setState("bump");
		PlaySound(sfx_bump);
		
	}
}