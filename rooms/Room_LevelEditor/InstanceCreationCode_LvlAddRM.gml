onClick = function() {
	//Make it visually
	var list = MaxGUI_FindElement("lE_L");
	//256/5 = (32 [sprite height] * 8 [yscale]) / 5 [squish to fit]
	list.Add("Room " + string(array_length(list.list) + 1));

	//Now actually create it
	o_LevelEditor.createRoom();
}