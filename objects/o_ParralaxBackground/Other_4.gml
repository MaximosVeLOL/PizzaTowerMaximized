//if(room == endRoom) instance_destroy();


show_debug_message("XSCALE");
for(var i = 0 ; i < array_length(backgrounds);i++) { //Scale the background once, not twice! Saves on CPU Cycles...
	var currentBackground = backgrounds[i];
	layer_background_xscale(currentBackground.layerID, currentBackground.scale);
	layer_background_yscale(currentBackground.layerID, currentBackground.scale);
	show_debug_message(layer_background_get_xscale(currentBackground.layerID));
}
show_debug_message("END");