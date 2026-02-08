offset = [0,0];
isInteracting = false;
active = true;
SetActive = function(value) {
	active = value;
}

Toggle = function() {
	active = !active;
}