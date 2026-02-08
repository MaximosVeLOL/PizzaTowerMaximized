event_inherited();
doHighlight = false;

i = 0;
if(array_length(elements) > 0 && is_string(elements[0])) {
	for(i = 0 ; i < array_length(elements);i++) {
		var elName = elements[i];
		elements[i] = FindElement(elements[i]);
		//show_message(elements[i]);
		if(elements[i] == noone) {
			throw("Undefined element at " + string(i) + " (" + elName + ")");
		}
	}
}

SetVisibility = function(visbililty) {
	for(i = 0 ; i < array_length(elements);i++) {
		elements[i].visible = visbililty;
	}
}
Toggle = function() {
	for(i = 0 ; i < array_length(elements);i++) {
		elements[i].Toggle();
	}
}
Add = function(element) {
	array_push(elements, element);
}
Destroy = function() {
	instance_destroy();
	for(i = 0 ; i < array_length(elements);i++) {
		instance_destroy(elements[i]);
	}
}
SetVisibility(visible);