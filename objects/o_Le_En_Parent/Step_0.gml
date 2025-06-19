switch(state) {
	case "idle":
		velocity[0] = 0;
		if(PLAYER_GROUNDED) {
				if(curSprite == "fall") {
				PlaySound(sfx_land);
				CreateEffect({sprite_index : sprite_effect_landcloud});
				setState("land");
				//setSprite("land");
			}
			setSprite("idle");
		}
		else setSprite("fall");
		if(round(image_index) == image_number) {
			setState("walk");
		}
	break;
	
	case "turn":
		velocity[0] = 0;
		setSprite("turn");
		SPRITE_NO_REPEAT;
		if(round(image_index) == image_number) {
			setState("idle");
			image_xscale = -image_xscale;
		}
	break;
	
	case "hitspecial":
		velocity = [0,0];
		curMass = 0;
		setSprite((tempVar[1] ? "hit_ceiling" : "hit_wall"));
		if(round(image_index) == image_number) {
			setSprite("stunfalltrans");
			velocity[0] = tempVar[1] ? 0 : image_xscale * random_range(1,4);
			setState("hit");
		}
		dropPoints = true;
	break;
	
	case "rolling":
		setSprite("rolling");
		if(PLAYER_TOUCHING_IMAGE) {
			setState("hitspecial");
			tempVar[0] = true;
		}
		dropPoints = true;
	break;
	
	case "walk":
		if(PLAYER_GROUNDED) {
			if(curSprite == "fall") {
				setState("land");
				PlaySound(sfx_land);
				CreateEffect({sprite_index : sprite_effect_landcloud});
			}
			velocity[0] = image_xscale * movespeed;
			setSprite("walk");
		}
		else {
			velocity[0] = 0.1 * image_xscale; //TODO - Test to see if its just bad coding or its a true effect.
			setSprite("fall");
		}
		if(PLAYER_TOUCHING_IMAGE || !place_meeting(x + (32 * image_xscale), y + 1, o_C_Parent)) setState("turn");
	break;
	
	case "land":
		velocity[0] = 0;
		setSprite((animVar ? "recover" : "land"));
		SPRITE_NO_REPEAT;
		if(round(image_index) == image_number) setState("idle");
	break;
	
	case "hit":
		if(round(image_index) == image_number) {
			if(curSprite == "hit") {
				if(velocity[1] < 0) setSprite("flying");
				else setSprite("stunfalltrans");
			}
			if(curSprite == "stunfalltrans") setSprite("stunfall");
		}
		if(place_meeting(x,y-1,o_C_Wall)) {
			if(place_meeting(x,y-1,o_B_Block)) instance_destroy(instance_place(x,y-1,o_B_Block));
			setState("hitspecial");
			PlaySound(sfx_facestomp);
		}
		//TODO - Add stun and flying animations
		if(PLAYER_GROUNDED && velocity[1] >= 0) {
			setState("stunned");
			tempVar[0] = 200;
			setSprite("stunland");
			CreateEffect({sprite_index : sprite_effect_landcloud});
		}
		
		if(place_meeting(x + -image_xscale, y, o_C_Wall) && velocity[1] <= 0) {
			PlaySound(sfx_facestomp);
			setState("hitspecial");
			tempVar[0] = true;
		}
		dropPoints = true;
	break;
	
	case "stunned":
		velocity[0] = 0;
		if(round(image_index) == image_number) {
			if(curSprite == "stunland") setSprite("stunned");
			if(curSprite == "stomped") setSprite("stunland");
		}
		//if(!PLAYER_GROUNDED) setState("hit");
		tempVar[0]--;
		if(tempVar[0] == 0) {
			setState("land"); //Recover is the same code, just different sprites.
			animVar = true;
		}
		dropPoints = true;
	break;
	
	case "grabbed":
		setSprite("stunfall"); //Grabbed sprite is the same as stun fall.
		var parent = instance_find(o_PlayerParent, targetPD - 1);
		image_xscale = -parent.xscale;
		x = parent.x + (15 * parent.xscale);
		y = parent.y;
		if(parent.state != "enemy") setState("hit");
		return;
	break;
	
	case "fly":
		setSprite("flying");
		velocity[1] = 0;
		if(place_meeting(x - image_xscale, y, o_C_Wall)) {
			setState("hitspecial");
			tempVar[1] = true;
			tempVar[0] = 20;
		}
	break;
}
if(dropPoints && tempVar[2] != 0) {
	tempVar[2]--;
	with(instance_create_depth(x,y,0,o_Le_Points)) {
		isStatic = false;
		velocity = [other.image_xscale * random_range(3, 5), random_range(-3, -10)];
	}
}
CollideAndMove(curMass);