enum OptionType {
	Button = 0,
	Toggle = 1,
	Slider = 2,
	List = 3,
};
enum IntroType {
	FromTop = 0,
	FromBottom = 1,
	FromLeft = 2,
	FromRight = 3,
};
useMouse = false;
clicked = false;
prevMouse = 0;
disableSelection = false;
function Option(pName, pType, pEvent) constructor {
	name = pName;
	type = pType;
	
	//Indexes count as methods because of ids...
	if(typeof(pEvent) == "method")
		OnEvent = pEvent
	else event = pEvent;;
	
	GetValue = function() {
		return struct_get(screens[currentScreen].targetStruct, event);
	}
}
onPressed = function(option){};
function Screen_Animation(pOnStart = false, pTargetPos = new Vector(), pType = 0) constructor {
	onStart = pOnStart;
	update = pOnStart;
	targetPosition = pTargetPos;
	introType = pType;
}
function Screen_Background(pSprite = noone, pColor = c_purple, pXSpeed = 0, pYSpeed = 0, pFontColorEnabled = c_white, pFontColorDisabled = c_gray, pFont = global.misc.font, pHAlign = fa_left, pVAlign = fa_top) constructor {
	color = pColor;
	sprite = pSprite;
	xSpeed = pXSpeed;
	ySpeed = pYSpeed;
	hAlign = pHAlign;
	vAlign = pVAlign;
	font = pFont;
	fontColor = pFontColorEnabled;
	fontColorDisabled = pFontColorDisabled
	position = new Vector();
}
function Screen_List(pTargetVar, pValues, pAlignToTop = false) constructor {
	targetVar = pTargetVar;
	values = pValues;
	selected = 0;
	alignToTop = pAlignToTop;
}
/*
	Movement modes:
		0 - up down or left right
		1 - Up down
		2 - left right
		3 - none
*/
function Screen(pName, pOptions, pHeader, pBackground = new Screen_Background(), pMovementMode = 0, pAnim = undefined, pStartPos = new Vector(), pOptionOffset = new Vector(480, 270), pTargetStruct = undefined) constructor {
	name = pName;
	options = pOptions;
	header = pHeader;
	movementMode = pMovementMode;
	animation = pAnim;
	background = pBackground;
	//For animation
	//startingPosition = pStartPos;
	position = pStartPos;
	startingPosition = pStartPos;
	offset = pOptionOffset;
	targetStruct = pTargetStruct;
	
}
/*
testStruct = {
	boolean : false,
	slider : 50,
	list : 0,
};

screens = [
	new Screen("Test", [
		new Option("Button", OptionType.Button, function(){show_message("Button event")}),
		new Option("Toggle", OptionType.Toggle, "boolean"),
		new Option("Slider", OptionType.Slider, "slider"),
		new Option("List", OptionType.List, new Screen_List("list", ["Pre ETB", "ETB"])),
	], "Header", new Screen_Background(), 1, undefined, new Vector(), new Vector(480, 270), testStruct)
];*/
screens = [];
currentScreen = 0;
currentOption = 0;
interactingWithOption = false;
listOption = 0;
history = []; //Holds indexes
setScreen = function(indexOrName) {
	array_push(history, currentScreen);
	if(typeof(screens[currentScreen].animation) != "undefined") {
		screens[currentScreen].position = screens[currentScreen].startingPosition;
		screens[currentScreen].animation.update = screens[currentScreen].animation.onStart;
    }
	currentOption = 0;
	interactingWithOption = false;
	io_clear();
	if(typeof(indexOrName) == "string") {
		var i = 0;
		for(; i < array_length(screens);i++) {
			if(screens[i].name == indexOrName) {
				currentScreen = i;
				return;
			}
		}
		if(i == array_length(screens))
			throw("Failed to find target screen (" + indexOrName + ")!");
	}
	PlaySound(sound_menuscreenchange, true);
	currentScreen = indexOrName;
}

setAllToUpper = function() {
	for(var i = 0 ; i < array_length(screens);i++) {
		screens[i].header = string_upper(screens[i].header);
		for(var j = 0; j < array_length(screens[i].options);j++) {
			screens[i].options[j].name = string_upper(screens[i].options[j].name);
			//This is a lot of values!
			if(screens[i].options[j].type == OptionType.List) {
				//show_message(string(screens[i].options[j]));
				for(var l = 0 ; l < array_length(screens[i].options[j].event.values);l++) {
					screens[i].options[j].event.values[l] = string_upper(screens[i].options[j].event.values[l]);
				}
			}
		}
	}
}
use = function() {
	var current = screens[currentScreen];
	var curOpt = screens[currentScreen].options[currentOption];
	switch(curOpt.type) {
		case OptionType.Button:
			if(variable_struct_exists(curOpt, "OnEvent"))
				curOpt.OnEvent();
			else {
				setScreen(curOpt.event);
			}
		return;
		
		case OptionType.Toggle:
			variable_struct_set(current.targetStruct, curOpt.event, !variable_struct_get(current.targetStruct, curOpt.event));
		return;
		
		case OptionType.Slider:
			

		break;
		
		case OptionType.List:
			
			if(interactingWithOption) {
				variable_struct_set(current.targetStruct, curOpt.event.targetVar, listOption);
				listOption = 0;
			}
			else curOpt.event.selected = variable_struct_get(current.targetStruct, curOpt.event.targetVar);
			//Show list
		break;
		
		default:
			//throw("Undefined option for screen (" + string(currentScreen) + "), option (" + string(currentOption) + ")");
			var ret = onPressed(currentOption);
            if(ret) return;
		break;
	}
	interactingWithOption = !interactingWithOption;
	clicked = false;
}
setAllToUpper();