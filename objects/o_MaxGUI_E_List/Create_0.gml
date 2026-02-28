event_inherited();
doHighlight = false;
currentListIndex = 0;
elementHeight = sprite_height / array_length(list);

Add = function(element, newSize = -1) {
	array_push(list, element);
	elementHeight = (newSize != -1 ? newSize : sprite_height / array_length(list));
}