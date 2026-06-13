var temp = [];
var i = 0;
var j = 0;
for(; i < instance_count;i++) {
	array_push(temp, instance_id_get(i));
	for(j = 0;j < array_length(seenIDs);j++) {
		if(instance_id_get(i) == seenIDs[i])
			show_message("Found ID!");
	}
}
for(i = 0; i < array_length(temp);i++) {
	array_push(seenIDs, temp[i]);
}
array_delete(temp, 0, array_length(temp) - 1);