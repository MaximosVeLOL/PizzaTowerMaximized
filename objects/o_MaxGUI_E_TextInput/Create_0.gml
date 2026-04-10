event_inherited();
text = placeholder;
isTyping = false;
typeTimer = 0;
FinishTyping = function() {
	onDoneTyping(text);
	isTyping = false;
	o_MaxGUI_Handler.isTyping = false;
}
