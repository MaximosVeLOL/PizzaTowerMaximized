frames++;
if(frames == 3) image_alpha = 0;
if(frames == 6) image_alpha = 0.8;
if(frames == 15) instance_destroy();
if(instance_exists(o_PlayerParent)) {
	if(instance_exists(o_Player_PreETB)) {
		if(o_Player_PreETB.state != "mach2") instance_destroy();
	}
	else {
		if(o_PlayerParent.state != "mach3" && o_PlayerParent.state != "superJump" && o_PlayerParent.state != "machroll") instance_destroy();
	}
}