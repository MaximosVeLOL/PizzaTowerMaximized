enum EnemyState {
    Idle = 0,
    Turn,
    
    HitSpecial,
    Rolling,
    Walk,
    Land,
    Hit,
    Stunned,
    Grabbed,
    Fly,
	//For the pizza goblin
	Custom
    
};

function Script_Enemy_ETB_Idle() {
    velocity.x = movespeed * image_xscale;
    if(PLAYER_GROUNDED) {
            if(sprite_index == sprite.fall) {
            PlaySound(sfx_land);
            CreateEffect({sprite_index : sprite_effect_landcloud});
            sprite_index = sprite.land;
            //setSprite("land");
        }
        sprite_index = sprite.idle;
        movespeed = 0;
        if(IMAGE_COMPLETE) {
            setState(EnemyState.Walk);
            movespeed = 1.5;
        }
    }
    else {
        sprite_index = sprite.fall;
        movespeed = (movespeed < 0 ? movespeed + 0.1 : 0);
    }
}
function Script_Enemy_ETB_Turn() {
        velocity.x = 0;
		sprite_index = sprite.turn;
		SPRITE_NO_REPEAT;
		if(IMAGE_COMPLETE) {
			setState(EnemyState.Idle);
			image_xscale = -image_xscale;
		}
}
function Script_Enemy_ETB_HitSpecial() {
    velocity.x = 0;velocity.y = 0;
    curMass = 0;
    sprite_index =(tempVar[1] ? sprite.hitceiling : sprite.hitwall);
	//setSprite((tempVar[1] ? "hit_ceiling" : "hit_wall"));
    if(IMAGE_COMPLETE) {
        sprite_index = sprite.stunfalltrans;
		//setSprite("stunfalltrans");
        if(tempVar[1]) { //BUG: when hitting a ceiling, and goes into the hit state, it gets hit again.
            velocity.x = 0;
            velocity.y = 4;
        }
        else {
            velocity.x = image_xscale * random_range(1, 4);
            velocity.y = 0;
        }
        
        setState(EnemyState.Hit);
    }
    dropPoints = true;
}
function Script_Enemy_ETB_Rolling() { 
   sprite_index = sprite.rolling; 
	//setSprite("rolling");
    if(PLAYER_TOUCHING_IMAGE) {
		setState(EnemyState.HitSpecial);
        tempVar[0] = true;
    }
    dropPoints = true;
}
function Script_Enemy_ETB_Walk() {
    if(PLAYER_GROUNDED) {
        if(sprite_index = sprite.fall) {
            setState(EnemyState.Land);
            PlaySound(sfx_land);
            CreateEffect({sprite_index : sprite_effect_landcloud});
        }
        velocity.x = image_xscale * movespeed;
        sprite_index = sprite.walk;
    }
    else {
        velocity.x = 0.1 * image_xscale; //TODO - Test to see if its just bad coding or its a true effect.
        sprite_index = sprite.fall;
    }
    if(PLAYER_TOUCHING_IMAGE || !place_meeting(x + (32 * image_xscale), y + 1, o_C_Parent)) setState(EnemyState.Turn);
}
function Script_Enemy_ETB_Land() {
    velocity.x = 0;
    sprite_index = (animVar ? sprite.recover : sprite.land);
	//setSprite((animVar ? "recover" : "land"));
    SPRITE_NO_REPEAT;
    if(IMAGE_COMPLETE) setState(EnemyState.Idle);
}
function Script_Enemy_ETB_Hit() {
		if(sprite_index = sprite.stunfall && !animVar) {
			sprite_index = sprite.flying;
			//setSprite("flying");
			animVar = true;
		}
		else if(sprite_index == sprite.flying && velocity.y >= 0) sprite_index = sprite.stunfalltrans;
		if(IMAGE_COMPLETE) {
			if(sprite_index = sprite.hit) sprite_index = sprite.flying;
			else if(sprite_index == sprite.stunfalltrans) sprite_index = sprite.stunfall;
		}
		if(place_meeting(x,y-2,o_C_Wall)) {
			if(place_meeting(x,y-2,o_B_Block)) instance_destroy(instance_place(x,y-2,o_B_Block));
			if(place_meeting(x+16,y-2,o_B_Block)) instance_destroy(instance_place(x+16,y-2,o_B_Block));
			setState(EnemyState.HitSpecial);
			tempVar[1] = true;
			PlaySound(sfx_facestomp);
		}
		//TODO - Add stun and flying animations
		if(PLAYER_GROUNDED && velocity.y >= 0) {
			setState(EnemyState.Stunned);
			tempVar[0] = 200;
			sprite_index = sprite.stunland;
			//setSprite("stunland");
			CreateEffect({sprite_index : sprite_effect_landcloud});
		}
		
		if(place_meeting(x + -image_xscale, y, o_C_Wall) && velocity.y <= 0) {
			PlaySound(sfx_facestomp);
			setState(EnemyState.HitSpecial);
			tempVar[0] = true;
		}
		dropPoints = true;
}
function Script_Enemy_ETB_Stunned() {
	velocity.x = 0;
	if(IMAGE_COMPLETE) {
		if(sprite_index == sprite.stunland) sprite_index = sprite.stunned;
			//if(curSprite == "stunland") setSprite("stunned");
		else if(sprite_index == sprite.stomped) sprite_index = sprite.stunland;
			//if(curSprite == "stomped") setSprite("stunland");
	}
	//if(!PLAYER_GROUNDED) setState(EnemyState.Hit);
	tempVar[0]--;
	if(tempVar[0] == 0) {
		setState(EnemyState.Land); //Recover is the same code, just different sprites.
		animVar = true;
	}
	dropPoints = true;
}
function Script_Enemy_ETB_Grabbed() {
	//setSprite("stunfall"); //Grabbed sprite is the same as stun fall.
	sprite_index = sprite.stunfall;
	image_xscale = -plr.xscale;
	x = plr.x + ((15 + plr.movespeed) * plr.xscale);
	y = plr.y;
	if(plr.state != PlayerState.Enemy) setState(EnemyState.Hit);
	return true;
}
function Script_Enemy_ETB_Fly() {
	//setSprite("flying");
	sprite_index = sprite.flying;
	velocity.x = tempVar[1];
	velocity.y = 0;
	if(place_meeting(x - (image_xscale * 2), y, o_B_Parent)) {
		if(!place_meeting(x - (image_xscale * 2), y, o_B_Metal)) {
			instance_destroy(instance_place(x - (image_xscale * 2), y, o_B_Parent));
		} 		
	}
	else {
		if(place_meeting(x - (image_xscale * 2), y, o_C_Wall)) {
			setState(EnemyState.HitSpecial);
			tempVar[1] = true;
			tempVar[0] = 20;
		}		
	}


	if(place_meeting(x - (image_xscale * 2), y, o_C_Slope)) {
		y--;
	}
}

//function Script_Enemy_ETB_