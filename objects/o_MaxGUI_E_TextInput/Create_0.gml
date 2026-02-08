event_inherited();
text = "Type here";
isTyping = false;
typeTimer = 0;
FinishTyping = function() {
	onDoneTyping(text);
	isTyping = false;
	o_GUIHandler.isInteracting = false;
}
