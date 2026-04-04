room_persistent = false;
room_restart();
index++;
if(index >= array_length(roomData)) {
	room_goto(originalRoom);
	gc_collect();
}
else room_goto(roomData[index]);