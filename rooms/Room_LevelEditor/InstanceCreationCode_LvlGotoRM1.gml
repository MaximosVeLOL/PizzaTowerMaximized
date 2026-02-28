onClick = function() {
	var target = MaxGUI_FindElement("lE_L").currentListIndex;
	room_goto(o_LevelEditor.rooms[target]);
	o_LevelEditor.offset = [0,0];
}