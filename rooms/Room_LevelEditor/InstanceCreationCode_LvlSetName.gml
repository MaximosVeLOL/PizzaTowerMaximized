onClick = function() {
	MaxGUI_CreatePrompt(680, 270, 14, 9, function(text) {
		o_LevelEditor.level.name = "text";
	}, "Set the level name");
}