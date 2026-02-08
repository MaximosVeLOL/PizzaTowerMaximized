#macro DEBUG true
#macro COLOR_HIGHLIGHT c_white
#macro COLOR_TEXT c_white

function FindElement(elName) { //Como se llama guey?
	with(o_MaxGUI_E_ElementParent) {
		if(name == elName) return id;
	}
	return noone;
}
function GetElementVariable(element, varName) {
	if(element == noone || !variable_instance_exists(element, varName)) return undefined;
	return variable_instance_get(element, varName);
}



function CreatePrompt( x, y, w, h, onComplete, textToDisplay = "This is a prompt, type something!") {
	var groupMaster = instance_create_depth(x,y,0,o_MaxGUI_E_Group);
	groupMaster.name = "PromptGroup";
	x -= w * 16;
	y -= h * 16;
	groupMaster.Add(instance_create_depth(x,y, -20,o_MaxGUI_E_Window, {image_xscale : w, image_yscale : h}));
	groupMaster.Add(instance_create_depth(x + ((w * 32) / 2), y + 32 , -25, o_MaxGUI_E_Text, {text : textToDisplay, horAlign : fa_center} ));
	groupMaster.Add(instance_create_depth(x + 32,y + 64,-25,o_MaxGUI_E_TextInput, {image_xscale : w - 2, image_yscale : 2, onDoneTyping : onComplete, name : "PromptTextInput"}));
	
	groupMaster.Add(instance_create_depth(x + 96,y + 160,-25,o_MaxGUI_E_Button, {image_xscale : 3, image_yscale : 3, text : "Ok", onClick : function() {
		if(FindElement("PromptTextInput").FinishTyping())
			FindElement("PromptGroup").Destroy();
	}}));
	groupMaster.Add(instance_create_depth(x + 256, y + 160, -25, o_MaxGUI_E_Button, {image_xscale : 3, image_yscale : 3, text : "Cancel", onClick : function(){
		FindElement("PromptGroup").Destroy();
	}}));

	return groupMaster;
}
function RoundToGrid(val, grid) {
	return round(val / grid) * grid;
}