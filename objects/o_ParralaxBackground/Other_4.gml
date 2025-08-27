//if(room == endRoom) instance_destroy();


show_debug_message("XSCALE & ID");
for(i = 0 ; i < array_length(backgrounds);i++) { //Scale the background once, not twice! Saves on CPU Cycles...
	backgrounds[i].layerID = layer_get_id(backgrounds[i].layerName);
	show_debug_message("ID: " + string(backgrounds[i].layerID));
	layer_background_xscale(backgrounds[i].layerID, backgrounds[i].scale);
	layer_background_yscale(backgrounds[i].layerID, backgrounds[i].scale);
	show_debug_message(layer_background_get_xscale(backgrounds[i].layerID));
}
show_debug_message("END");