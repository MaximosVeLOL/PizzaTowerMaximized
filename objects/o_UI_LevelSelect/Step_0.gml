targetRoom += GetInput("right", 1) - GetInput("left", 1);
if(targetRoom < room_first) targetRoom = room_last;
if(targetRoom > room_last) targetRoom = 0;
if(GetInput("jump", 1)) {
	room_goto(targetRoom);
	instance_create_depth(room_width / 2, room_height / 2, 0, o_PlayerParent);
}