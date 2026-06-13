if(other.state != PlayerState.Hurt && other.state != PlayerState.Hump) { //Hump hump hump!
	if(isStunned) {
		if(other.state == PlayerState.Mach3 || other.state == PlayerState.Mach2) {
			die();
		}
	}
	else {
		if(other.state == PlayerState.Jump && other.velocity.y > 0) {
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
		tempVar[0] = (other.state != PlayerState.Mach3 && other.state != PlayerState.Mach2);
		other.setState("bump");
		PlaySound(sfx_bump);
	}
}