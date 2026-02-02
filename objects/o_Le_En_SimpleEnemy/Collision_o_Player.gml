if(other.state != "hurt" && other.state != "tackle") { //Hump hump hump!
	if(state != "stun") {
		if(other.state == "jump" && other.velocity.y > 0) {
			other.velocity.y = -7;
			other.tempVar[1] = true;
			PlaySound(sfx_boing);
			return;
		}
		
		var newV = image_xscale * -3;
		image_xscale *= -1;
		velocity.x = newV;
		
		velocity.x = newV;
		velocity.y = -3;
		other.velocity.x = newV;
		other.velocity.y = -3;
		state = "stun";
		tempVar[0] = (other.state != "mach3" && other.state != "mach2");
		other.setState("bump");
		PlaySound(sfx_bump);
		
	}
	else if(other.state == "mach3" || other.state == "mach2") {
		die();
	}
}