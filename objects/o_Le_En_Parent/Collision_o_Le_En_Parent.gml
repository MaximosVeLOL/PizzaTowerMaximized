if(state != "hit" && state != "fly" || other.state == "grabbed") return;
CreateEffect({sprite_index : sprite_effect_bang});

if(state == "fly") {
	other.setState("hit");
	other.velocity.x = 5 * image_xscale;
	other.velocity.y = -10;
	return;
}

//if(bbox_bottom > other.y) return;
setState("idle");
movespeed = -7; //When thrown, we are always 7.
setSprite("fall");
velocity.y = -14;
other.setState("stunned");
other.setSprite("stomped");
other.tempVar[0] = 200;