if(state == "stunned" && other.state == "normal") { //Grabbing when stunned
	CreateEffect({x : (self.x + (other.xscale * 40)), sprite_index : sprite_effect_punchdust});
	other.setState("enemy");
	other.tempVar[2] = self;
	targetPD = other.PD;
	setState("grabbed");
}
if((other.state == "jump" && GetInput("jump", 0, other.PD) || other.state == "freefall") && other.velocity[1] > 0) {
	setState("stunned");
	setSprite("stomped");
	if(other.state == "jump") PlaySound(sfx_boing, true);
	other.tempVar[1] = true;
	other.velocity[1] = other.state == "freefall" ? -7 : -14;
	tempVar[0] = 200;
}
with(other) {
	//There is another if statement, but it gets replaced by this. HE is so stupiddddddeddddddd
	if(other.state != "hitspecial" && PLAYER_GROUNDED && (string_count("mach", state) || state == "something") ) {
		other.image_xscale = -xscale;
		other.velocity[0] = xscale * 5;
		if(state == "mach3" || state == "machroll") other.velocity[1] = -18;
		else other.velocity[1] = -10;
		other.setState("hit");
		other.setSprite("hit");
		other.tempVar[0] = 200;
		
		CreateEffect({sprite_index : sprite_effect_bang});
	}
}