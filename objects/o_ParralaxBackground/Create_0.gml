if(global.settings.gameplay.fpsSave == FPSSaveMode.VisualRemover || global.settings.gameplay.fpsSave == FPSSaveMode.OnlyTheNeccessary) {
	instance_destroy();
	//return; We need createBackground()
}

backgrounds = [];
i = 0;
endRoom = -1;
if(endRoom != -1) persistent = true;

createBackground = function(inLayer, inDepth, inScale) {
	return {layerName : inLayer, layerID : -1, depth : inDepth, scale : inScale, ogY : -1};
}
