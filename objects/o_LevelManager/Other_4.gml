Log("Setting up room " + string(index));
onStart();
index++;
if(index >= array_length(roomData)) {
	room_goto(originalRoom);
	gc_collect();
	instance_activate_all();
}
else room_goto(roomData[index]);