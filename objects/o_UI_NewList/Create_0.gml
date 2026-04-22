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

function Option(pName, pType, pEvent, ) constructor {
	name = pName;
	type = pType;
	
	if(is_callable(pEvent))
		OnEvent = pEvent;
	else event = pEvent;
	
	GetValue = function() {
		return struct_get(screens[currentScreen].targetStruct, event);
	}
}

function Screen_Animation(pOnStart = false, pTargetPos = new Vector(), pType = 0) constructor {
	onStart = pOnStart;
	update = pOnStart;
	targetPosition = pTargetPos;
	introType = pType;
}
function Screen_Background(pSprite = noone, pColor = c_purple, pXSpeed = 0, pYSpeed = 0, pFont = global.misc.font) constructor {
	color = pColor;
	sprite = pSprite;
	xSpeed = pXSpeed;
	ySpeed = pYSpeed;
	hAlign = fa_left;
	vAlign = fa_top;
	font = pFont;
	fontColor = c_white;
	position = new Vector();
}
function Screen_List(pTargetVar, pValues) constructor {
	targetVar = pTargetVar;
	values = pValues;
	selected = 0;
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
screens = [
	new Screen("Test", [
		new Option("Button", OptionType.Button, function(){show_message("Button event")}),
		//new Option("Toggle", OptionType.Toggle, "surroundSound"),
		//new Option("Slider", OptionType.Slider, "sfxVolume"),
		new Option("List", OptionType.List, new Screen_List("moveSet", ["Pre ETB", "ETB"])),
	], "Header", new Screen_Background(), 1, undefined, new Vector(), new Vector(480, 270), global.settings.player)
];
currentScreen = 0;
currentOption = 0;
interactingWithOption = false;
listOption = 0;
history = []; //Holds indexes
setScreen = function(indexOrName) {
	array_push(history, currentScreen);
	if(screens[currentScreen].animation != undefined) {
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
	currentScreen = indexOrName;
}

setAllToUpper = function() {
	for(var i = 0 ; i < array_length(screens);i++) {
		screens[i].header = string_upper(screens[i].header);
		for(var j = 0 ; j < array_length(screens[i].options);j++) {
			screens[i].options[j].name = string_upper(screens[i].options[j].name);
		}
	}
}
setAllToUpper();