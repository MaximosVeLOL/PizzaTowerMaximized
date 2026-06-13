if(state != EnemyState.Hit && state != EnemyState.Fly || other.state == EnemyState.Grabbed) return;
CreateEffect({sprite_index : sprite_effect_bang});

if(state == EnemyState.Fly) {
	if(other.object_index == o_Le_En_Cheeseslime) {
		other.die(true);
		return;
	}
	other.setState(EnemyState.Hit);
	other.velocity.x = 5 * image_xscale;
	other.velocity.y = -10;
	return;
}

//if(bbox_bottom > other.y) return;
//setState("idle");
movespeed = -7; //When thrown, we are always 7.
sprite_index = sprite.fall;
velocity.y = -14;
other.setState(EnemyState.Stunned);
other.sprite_index = sprite.stomped;
other.tempVar[0] = 200;