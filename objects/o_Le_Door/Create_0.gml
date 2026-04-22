if(typeof(targetRoom) == "string")
	targetRoom = o_LevelEditor.rooms[real(targetRoom)];
if(typeof(targetPos) == "string") {
	var s = string_split(targetPos, " ");
	targetPos = new Vector(real(s[0]), real(s[1]));
}
//Hacky hack hack hack
if(room != ETBRoom_T3) depth = 0;
/*
if(targetRoom == -1) {
	LogError("We are useless! Destroying.settings..");
	instance_destroy();
}