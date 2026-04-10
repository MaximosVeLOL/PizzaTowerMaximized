onClick = function() {
	MaxGUI_CreatePrompt(680, 270, 14, 9, function(text) {
		try {
		o_LevelEditor.level.song = asset_get_index(text);
			return true;
		}
		catch(e) {
			return false;
		}
	}, "Set the level name");
}