offset = [0,0];
isInteracting = false;
isTyping = false;
active = true;
SetActive = function(value) {
	active = value;
}

Toggle = function() {
	active = !active;
}

Destroy = function() {
	with(o_MaxGUI_E_ElementParent) instance_destroy();
	instance_destroy();
}