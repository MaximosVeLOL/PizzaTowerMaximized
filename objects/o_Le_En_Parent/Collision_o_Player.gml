
	if(state == EnemyState.Stunned && other.state == PlayerState.Normal && global.settings.player.moveSet != Moveset.PreETB ) { //Grabbing when stunned
		CreateEffect({x : (other.x + (other.xscale * 40)), sprite_index : sprite_effect_punchdust});
		other.setState(PlayerState.Enemy);
		other.tempVar[2] = self;
		depth = other.depth; //M_OPTI - Should we do this?
		plr = other;
		setState(EnemyState.Grabbed);
	}
	if((other.state == PlayerState.Jump && GetInput("jump", 0) || other.state == PlayerState.Freefall) && other.velocity.y > 0) {
		setState(EnemyState.Stunned);
		sprite_index = sprite.stomped;
		with(other) {
            PlaySound(sfx_boing, true);
			if(state == PlayerState.Jump) { 
				
				image_index = 0;
				tempVar[2] = 1;
				velocity.y = -14;
			}
			else if(state == PlayerState.Freefall) {
				CreateEffect({sprite_index : sprite_effect_bang});
				tempVar[0] = 0; //State
				tempVar[1] = 0; //Timer
				animVar = true; //Hit animation
				image_index = 0;
				velocity.y = -7;
			}
		}
		tempVar[0] = 200;
	}
	//There is another if statement, but it gets replaced by this. HE is so stupiddddddeddddddd
	if(state != EnemyState.HitSpecial && PLAYER_GROUNDED && PlayerIsMachState(other.state) && other.state != PlayerState.Mach1 && other.state != PlayerState.Normal ) {
		image_xscale = -other.xscale;
		velocity.x = other.xscale * 5;
		if(other.state == PlayerState.Mach3 || other.state == PlayerState.MachRoll) velocity.y = -18;
		else velocity.y = -10;
		setState(EnemyState.Hit);
		sprite_index = sprite.hit;
		tempVar[0] = 200;
		CreateEffect({sprite_index : sprite_effect_bang});
	}