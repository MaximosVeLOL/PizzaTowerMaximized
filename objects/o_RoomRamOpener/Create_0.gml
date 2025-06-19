var startRoom = room;
for(var i = 0 ; i < room_last;i++) {
	room_goto(i);
	room_persistent = false;
	for(var j = 0; j < array_length(instance_id);i++) {
		show_message(string(instance_id[j]) + ", " + string(i));
		instance_destroy(instance_id[j]);
	}
	gc_collect();
}
room_goto(Room_Empty);
instance_destroy();