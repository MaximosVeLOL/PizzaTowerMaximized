if(state != "hit" && state != "fly" || other.state == "grabbed") return;
CreateEffect({sprite_index : sprite_effect_bang});

if(state == "fly") {
	other.setState("hit");
	other.velocity.x = 5 * image_xscale;
	other.velocity.y = -10;
	return;
}


setState("hit");
velocity.y = -12;
other.setState("stunned");
other.setSprite("stomped");
other.tempVar[0] = 200;