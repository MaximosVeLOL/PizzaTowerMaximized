onClick = function() {
	var textInput = MaxGUI_FindElement("1_i").text;
	o_MaxGUI_Handler.Destroy();
	try {
		instance_create(0, 0, o_LevelEditor).level.name = textInput;
		room_goto(Room_LevelEditor);
		return true;
	}
	catch(e) {
		return false;
	}
};