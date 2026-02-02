
	if(state == "stunned" && other.state == "normal" && global.settings.playerSettings.moveSet != Moveset.PreETB ) { //Grabbing when stunned
		CreateEffect({x : (other.x + (other.xscale * 40)), sprite_index : sprite_effect_punchdust});
		other.setState("enemy");
		other.tempVar[2] = self;
		setState("grabbed");
	}
	if((other.state == "jump" && GetInput("jump", 0) || other.state == "freefall") && other.velocity.y > 0) {
		setState("stunned");
		setSprite("stomped");
		with(other) {
			if(state == "jump") PlaySound(sfx_boing, true);
			tempVar[1] = true;
			velocity.y = state == "freefall" ? -7 : -14;
		}
		tempVar[0] = 200;
	}
	//There is another if statement, but it gets replaced by this. HE is so stupiddddddeddddddd
	if(state != "hitspecial" && PLAYER_GROUNDED && string_count("mach", other.state) && other.state != "mach1" && other.state != "normal" ) {
		image_xscale = -other.xscale;
		velocity.x = other.xscale * 5;
		if(other.state == "mach3" || other.state == "machroll") velocity.y = -18;
		else velocity.y = -10;
		setState("hit");
		setSprite("hit");
		tempVar[0] = 200;
		CreateEffect({sprite_index : sprite_effect_bang});
	}