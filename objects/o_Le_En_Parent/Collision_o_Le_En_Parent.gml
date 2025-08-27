if(state != "hit" && state != "fly" || other.state == "grabbed") return;
CreateEffect({sprite_index : sprite_effect_bang});

if(state == "fly") {
	other.setState("hit");
	other.velocity = [5 * image_xscale,-10];
	return;
}


setState("hit");
velocity[1] = -12;
other.setState("stunned");
other.setSprite("stomped");
other.tempVar[0] = 200;