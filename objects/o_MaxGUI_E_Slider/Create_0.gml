event_inherited();
SetValue = function(newValue, stayInBounds = false) {
	newValue = (stayInBounds ? clamp(newValue, minimumValue, maximumValue) : newValue);
}