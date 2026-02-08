onClick = function() {
	CreatePrompt(680, 270, 14, 9, function(prompt) {
		var asset = asset_get_index(prompt);
		if(asset != -1 && asset_get_type(asset) == asset_sprite) {
			var bg = layer_background_get_id(layer_get_id("Background"));
			layer_background_sprite(bg, asset);
			layer_background_blend(bg, c_white);
		}
		else return false;
		
		return true;
	}, "Enter a background name!")
}