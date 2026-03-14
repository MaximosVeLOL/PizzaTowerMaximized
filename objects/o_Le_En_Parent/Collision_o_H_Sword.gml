if(state != "fly") {
	image_xscale = -other.image_xscale;
	velocity.x = other.image_xscale * 5;
	velocity.y = -10;
	setState("hit");
	setSprite("flying"); //TODO - Implement setSprite("flying") in the hit state or do something better.
	CreateEffect({sprite_index : sprite_effect_bang});
	tempVar[0] = 200;
}
