onClick = function() {
	var textInput = MaxGUI_FindElement("1_i").text;
	o_MaxGUI_Handler.Destroy();
	try {
		var i = instance_create_depth(0, 0, 0, o_LevelEditor);
		i.level.name = textInput;
		room_goto(Room_LevelEditor);
		return true;
	}
	catch(e) {
		return false;
	}
};