instance_deactivate_all(true);
//Including a setup just incase

onStart = function() {
	room_persistent = false;
	room_restart();
};


index = 0;
originalRoom = room;

room_goto(roomData[0]);