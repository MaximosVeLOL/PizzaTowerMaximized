enum Moveset {
	Invalid = -1,
	//Used for transformations, cuz they are global
	Transformation,
	PreETB = 0,
	ETB = 1,
	Boxer = 2,
    Last = 3,
};

function GetPlayer(pIndex) {
	return (global.settings.multiplayer.enabled ? o_MultiplayerHandler.players[pIndex] : o_Player);
}
function ForEachPlayer(pFunction) {
	if(IS_DEBUGGING && !instance_exists(o_Player)) return;
	if(global.settings.multiplayer.enabled) {
		for(var i = 0 ; i < instance_number(o_Player);i++) {
			var ret = pFunction(i, GetPlayer(i));
			if(ret) break;
		}
	}
	else pFunction(0, o_Player);
}

/*
function S_ETB_Normal() : State(PlayerState.Normal) constructor {
	isJumping = false;
	idleTimer = 0;
	idleSprite = 0;
	onStart = function(){isJumping = false;idleTimer = 0;}
	onUpdate = function(moveX, moveY) {
		velocity.x = moveX * movespeed;
		if(moveX != xscale) movespeed = 0;
		if(moveX != 0) {
			plr.playSound(sfx_footstep);
			if(!self.isJumping) plr.sprite_index = spr_player_move;
			xscale = moveX;
			movespeed = (movespeed < 6 ? movespeed + 0.5 : 6);
			image_speed = (movespeed / 6);
			idleTimer = 0;
			CreateEffect({y : bbox_bottom, sprite_index : sprite_effect_cloud});
		}
		else {
			//if(audio_is_playing(sfx_footstep)) audio_stop_sound(sfx_footstep); //Why didn't we do this???
			stopSound(sfx_footstep);
			image_speed = 1; //Also prevents the sprite from playing too slow.
			sprite_index = idleSprite;
			if(idleSprite == 400) {
				if(IMAGE_COMPLETE) {
					
				}
			}
			if(GetInput("up", 1, playerID) && PLAYER_GROUNDED) setState(PlayerState.HighJump, true);
			
			
		}
		movespeed = movespeed > 6 ? movespeed - 0.5 : movespeed;
		if(GetInput("jump", 1, playerID)) {
			setState("jump");
			CreateEffect({sprite_index : (moveX != 0 ? sprite_effect_dust : sprite_effect_landcloud), image_xscale : o_Player.xscale});
			velocity.y = -9;
		}
		if(GetInput("down", 0, playerID)) setState("crouch");
		if(GetInput("dash", 0, playerID) && !PLAYER_TOUCHING) setState(PlayerState.Mach1, true, true);
		//if(GetInput("shoot", 1) && inventory.gun) setState("shotgun");
		//Move this to the end to ensure we are playing this sprite, that's probably why it wasn't working.
		if(tempVar[1]) {
			image_speed = 1; //Prevents the land sprite from playing too slow.
			sprite_index = spr_player_land;
			if(IMAGE_COMPLETE) tempVar[1] = false;
		}
		//Keep this at the end, ALWAYS!
		if(!PLAYER_GROUNDED) setState("jump");
	}
}


function CreateETBStates() {
	
	var ret = [
		
	];
}
*/