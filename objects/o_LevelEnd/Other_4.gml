room_restart();
room_persistent = false;
index++;
if(index >= array_length(roomData)) {
	room_goto(originalRoom);
}
else room_goto(roomData[index]);