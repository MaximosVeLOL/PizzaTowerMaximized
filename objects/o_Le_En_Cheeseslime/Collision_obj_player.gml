if(obj_player.state == "jump") {
	state = "bumped";
	image_index = 0;
	obj_player.setState("jump");
	obj_player.velocity[1] = -12;
}