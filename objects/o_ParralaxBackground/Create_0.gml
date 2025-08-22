backgrounds = [];
i = 0;
endRoom = -1;
if(endRoom != -1) persistent = true;

createBackground = function(inLayer, inDepth, inScale) {
	return {layerID : inLayer, depth : inDepth, scale : inScale};
}
