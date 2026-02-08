onClick = function() {
	CreatePrompt(680, 270, 14, 9, function(text){
		var bg = asset_get_index(text);
		if(bg == -1) return;
		layer_background_sprite(layer_get_id("Background"), bg);
	}, "Input background sprite name.");
}