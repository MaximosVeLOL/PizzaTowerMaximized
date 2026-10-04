function ShakeCamera(mag, acc) {
	if(IS_DEBUGGING && !instance_exists(o_Camera)) return;
	o_Camera.shake.mag = mag;
	o_Camera.shake.acc = acc;
	with(o_Le_En_Parent) {
		if(object_index != o_Le_En_Cheeseslime && point_in_rectangle(x,y,camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]), camera_get_view_x(view_camera[0]) + 960, camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) + 540 )) {
			velocity.x = 0;
			velocity.y = -7;
			setState(EnemyState.Hit);
			sprite_index = sprite.hit;
			tempVar[0] = 200;
		}
	}
}

function CollideAndMove(mass, maxYVelocity = 20, interactWithWater = false, useSlopes = true) {
	if(!PLAYER_GROUNDED) velocity.y += (place_meeting(x, y, o_Le_Water) && interactWithWater && global.settings.player.waterInteraction ? (global.settings.player.moveSet == Moveset.ETB ? (velocity.y >= 0 ? mass/1.25 : mass*1.25) : mass / 1.5) : mass);
	
	repeat(abs(velocity.y)) {
	    if !place_meeting(x, y + sign(velocity.y), o_C_Parent)
	        y += sign(velocity.y); 
	    else {
	        velocity.y = 0;
	        break;
	    }
	}

	// Horizontal
	repeat(abs(velocity.x)) {

		if(useSlopes) {
		    // Move up slope
		    if place_meeting(x + sign(velocity.x), y, o_C_Parent) && !place_meeting(x + sign(velocity.x), y - 1, o_C_Parent)
		        y--
    

		    // Move down slope
		    if !place_meeting(x + sign(velocity.x), y, o_C_Parent) && !place_meeting(x + sign(velocity.x), y + 1, o_C_Parent) && place_meeting(x + sign(velocity.x), y + 2, o_C_Parent)
		        y++;
		}

	    if !place_meeting(x + sign(velocity.x), y, o_C_Parent)
	        x += sign(velocity.x); 
	    else {
	        velocity.x = 0;
	        break;
	    }
	}
	/*
	if(place_meeting(x + velocity.x, y, o_C_Parent)) {
		// Alternative: if(!place_meeting(x + velocity.x, y - (abs(velocity.x) + 1), o_C_Parent ) ) while(place_meeting(x + velocity.x, y, o_C_Parent)) y--;
		for(var i = 0 ; i <= abs(velocity.x * 16);i++) {
			if(!place_meeting(x+velocity.x, y - i, o_C_Parent)) {
				y -= i;
				break;
			}
		}
		if(place_meeting(x+velocity.x,y,o_C_Parent)) {
			while(!place_meeting(x+sign(velocity.x), y, o_C_Parent)) x += sign(velocity.x);
			velocity.x = 0;
		}
	}
	if(place_meeting(x + velocity.x, y + velocity.y, o_C_Parent)) {
		while(!place_meeting(x + velocity.x, y + sign(velocity.y), o_C_Parent)) {
			y += sign(velocity.y);
		}
		velocity.y = 0;
	}
	x += velocity.x;
	y += velocity.y;
	*/
}
function CreateEffect(information) {
	if(global.settings.gameplay.fpsSave == FPSSaveMode.VisualRemover || global.settings.gameplay.fpsSave == FPSSaveMode.OnlyTheNeccessary) return;
	//if(!is_struct(information)) LogError("Invalid Effect!", true);
	if(information.sprite_index == sprite_effect_bang) PlaySound(choose(sfx_punch1, sfx_punch2, sfx_punch3, sfx_punch4, sfx_punch5), true);
	
	for(var i = 0 ; i < instance_number(o_P_Effect);i++) {
		//M_OPTI - Find a better way to check for same effects
		if(instance_find(o_P_Effect, i).sprite_index == information.sprite_index) return;
	}
	instance_create_depth(x,y,-1,o_P_Effect, information);
}
#macro IS_NETWORKING (instance_exists(Net_o_Client) || instance_exists(Net_o_Server))

