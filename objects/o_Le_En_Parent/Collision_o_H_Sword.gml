if(state != "fly") {
	image_xscale = -other.image_xscale;
	velocity = [other.image_xscale * 5, -10];
	setState("hit");
	CreateEffect({sprite_index : sprite_effect_bang});
	tempVar[0] = 200;
}
