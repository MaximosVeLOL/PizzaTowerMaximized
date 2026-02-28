onClick = function() {
	MaxGUI_CreatePrompt(o_LevelEditor.offset[0] + 680, o_LevelEditor.offset[1] + 270, 14, 9, function(text) {
		o_LevelEditor.projectName = text;
	}, "Set the level name");
}