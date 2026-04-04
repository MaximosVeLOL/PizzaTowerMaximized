event_inherited();
doHighlight = false;
currentListIndex = -1;
elementHeight = (array_length(list) > 0 ? sprite_height / array_length(list) : 32);

Add = function(element, newSize = -1) {
	array_push(list, element);
	elementHeight = (newSize != -1 ? newSize : sprite_height / array_length(list));
}