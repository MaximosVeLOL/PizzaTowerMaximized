
	if(other.state == "stunned" && state == "normal") { //Grabbing when stunned
		CreateEffect({x : (self.x + (xscale * 40)), sprite_index : sprite_effect_punchdust});
		setState("enemy");
		tempVar[2] = self;
		other.targetPD = PD;
		other.setState("grabbed");
	}
	if((state == "jump" && GetInput("jump", 0, PD) || state == "freefall") && velocity[1] > 0) {
		setState("stunned");
		setSprite("stomped");
		with(other) {
			if(state == "jump") PlaySound(sfx_boing, true);
			tempVar[1] = true;
			velocity[1] = state == "freefall" ? -7 : -14;
		}
		tempVar[0] = 200;
	}
	//There is another if statement, but it gets replaced by this. HE is so stupiddddddeddddddd
	if(state != "hitspecial" && PLAYER_GROUNDED && string_count("mach", state) && state != "mach1" && state != "normal" ) {
		image_xscale = -xscale;
		velocity[0] = xscale * 5;
		if(other.state == "mach3" || other.state == "machroll") velocity[1] = -18;
		else velocity[1] = -10;
		setState("hit");
		setSprite("hit");
		tempVar[0] = 200;
		CreateEffect({sprite_index : sprite_effect_bang});
	}