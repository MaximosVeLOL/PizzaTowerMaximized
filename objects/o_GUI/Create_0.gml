/* TODO LIST
DONE - make text element not an actual element (doesnt use width and height)
DONE - make panels like a screen but with a rect


*/
depth = 99999;
getMouse = function() {
	return [window_mouse_get_x(), window_mouse_get_y()];
}
isInteractingWithGUI = function() {
	for(var i = 0 ; i < array_length(getCurrentScreen().elements);i++) {
		with(getCurrentScreen().elements[i]) {
			if(!active) continue;
			mousePosition = o_GUI.getMouse();
			if(mousePosition[0] >= transform.x && mousePosition[0] <= transform.x + transform.width && mousePosition[1] >= transform.y && mousePosition[1] <= transform.y + transform.height) return true;
		}
	}
	return false;
}

function Vector2(_x,_y,w,h) constructor {
	x = _x;
	y = _y;
	width = w;
	height = h;
}


screens = [];
currentLayer = 0;

add = function(screen) {
	array_push(screens, screen);
}
getCurrentScreen = function() {
	return screens[currentLayer];
}
resizeTextByNewLine = function(width, text) {
	if(string_width(text) > width) {
		for(var i = string_length(text) ; i > 0;i--) {
			if(string_char_at(text, i) == " ") {
				text = string_copy(text, 0, i - 1) + "\n" + string_copy(text, i + 1, string_length(text));
				if(string_width(text) <= width) break;
			}
		}
	}
	return text;
}
resizeTextByPosition = function(text, xPos, errorMargin = 0) {
	while(string_width(text) + xPos + errorMargin > room_width) {
		xPos--;
	}
	return xPos;
}
alert = function(_message) {
	getCurrentScreen().Add(new MessageBox(480,270,300,300, _message));
}
prompt = function(_message, _onDestroy, targetType = 0, size = [300,300]) {
	var divi = [size[0] / 2, size[1] / 2];
	getCurrentScreen().Add(new Panel((SCREEN_SIZE[0] / 2) - divi[0], (SCREEN_SIZE[1] / 2) - divi[0], size[0], size[1], [new TextBox(SCREEN_SIZE[0] + divi[0], SCREEN_SIZE[1] + divi[1], size[0] - 50, 100, _onDestroy), new Button(SCREEN_SIZE[0] + (divi[0] - 20), SCREEN_SIZE[1] + (size[0] - 50), 50, 50, function(){o_GUI.getCurrentScreen().Destroy("prompt_panel")}, "Ok"), new Text(SCREEN_SIZE[0] + 10, SCREEN_SIZE[1] + 20, _message)]), "prompt_panel");
}
newScreen = function(newIndex) {
	getCurrentScreen().SetActive(false);
	currentLayer = newIndex;
}
function Screen(_elements = []) constructor {
	elements = _elements;
	isActive = true;
	
	static Add = function(element, _id = -1) {
		if(_id == -1) _id = string(array_length(elements));
		array_push(elements, element);
		element.ID = _id;
	}
	static Get = function(targetID) {
		for(var i = 0 ; i < array_length(elements);i++) {
			if(elements[i].ID == targetID) return elements[i];
		}
		return false;
	}
	static Destroy = function(targetID) {
		for(var i = 0 ; i < array_length(elements);i++) {
			if(elements[i].ID == targetID) {
				elements[i].onDestroy();
				array_delete(elements, i, 1);
				break;
			}
		}
	}
	static SetActive = function(newV) {
		isActive = newV;
	}
}

function Element(_x,_y,w,h, isActive = true) constructor {
	transform = new Vector2(_x,_y,w,h);
	ID = -1;
	step = function(){};
	onToggle = function(){};
	onDestroy = function(){};
	c_Back = c_black;
	c_Highlight = c_gray;
	active = isActive;
	static DrawRect = function() {
		draw_rectangle(transform.x , transform.y, transform.x + transform.width, transform.y + transform.height, false);
	}
	static Toggle = function() {
		active = !active;
		onToggle();
	}
}

function Button(_x,_y,w,h, _onClick, _text, isActive = true) : Element(_x, _y, w, h, isActive) constructor {
	onClick = _onClick;
	text = _text;
	c_Text = c_white;
	active = isActive;
	step = function() {
		if(inBounds) {
			draw_set_color(c_Highlight);
			if(mouseCheck) onClick();
		} else draw_set_color(c_Back);
		DrawRect();
		draw_set_color(c_Text);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_text(transform.x + (transform.width / 2), transform.y + (transform.height / 2), o_GUI.resizeTextByNewLine(transform.width, text));
	}
}
function Check(_x,_y,w,h, defaultVal = false, _onChange = function(){}, isActive = true ) : Element(_x, _y, w, h, isActive) constructor {
	onChange = _onChange;
	c_True = c_green;
	c_False = c_red;
	value = defaultVal;
	step = function() {
		if(inBounds) {
			draw_set_color(c_Highlight);
			if(mouseCheck) {
				onChange();
				value = !value;
			}
		}
		else draw_set_color(c_Back);
		DrawRect();
		if(value) draw_set_color(c_True);
		else draw_set_color(c_False);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_text(transform.x + (transform.width / 2), transform.y + (transform.height / 2), (value ? "TRUE" : "FALSE") );
	}
}
function Slider(_x,_y,w,h, defaultVal = 50, _onChange = function(){}, isActive = true ) : Element(_x, _y, w, h, isActive) constructor {
	onChange = _onChange;
	value = defaultVal;
	c_Bar = c_white;
	
	step = function() {
		if(inBounds && mouse_check_button(mb_left)) {
			value = mousePosition[0] - transform.x;
			value = clamp(value, 0, 200);
		}
		draw_set_color(c_Back);
		DrawRect();
		var WIDTH = 20;
		draw_set_color(c_Bar);
		draw_ellipse(transform.x + value, transform.y, transform.x + (value + WIDTH), transform.y + transform.height, false);
	}
}
function List(_x,_y, w, h, _information, _onChange = function(){}, _informationText = -1, _elementHeight = -1, _startingIndex = 0, isActive = true) : Element(_x ,_y, w, h, isActive) constructor {
	information = _information;
	informationAsText = _informationText;
	elementHeight = _elementHeight == -1 ? w / array_length(_information) : _elementHeight;
	onChange = _onChange;
	step = function() {
		var text; //Define new variables each loop loses data! I think, gml is very high level...
		var didClick = false;
		for(var i = 0 ; i < array_length(information);i++) {
			draw_set_color(c_Back);
			if(mousePosition[0] >= transform.x && mousePosition[0] <= transform.x + transform.width && mousePosition[1] >= transform.y + (elementHeight * i) && mousePosition[1] <= transform.y + (elementHeight * (i+1))) {
				if(mouseCheck && !didClick) {
					didClick = true;
					onChange(i);
				}
				draw_set_color(c_Highlight);
			}
			draw_rectangle(transform.x, transform.y + (elementHeight * i), transform.x + transform.width, transform.y + (elementHeight * (i+1)), false);
			text = string(information[i]);
			if(is_array(informationAsText)) text = informationAsText[i];
			draw_set_color(c_white);
			draw_text(transform.x, transform.y + (elementHeight * i + 1), text);
			
		}
	}
}
function Text(_x,_y, _text, isActive = true ) : Element(_x, _y, 0, 0, isActive) constructor {
	//x = _x;
	//y = _y;
	c_Back = c_white;
	text = _text;
	step = function() {
		//draw_set_halign(fa_center);
		//draw_set_valign(fa_middle);
		draw_set_color(c_Back);
		draw_text(transform.x, transform.y, text);
	}
}
//This lies unused, due to the way i actually implemented the object menu
function Panel(_x,_y,w,h, _elements, isActive = true) : Element(_x, _y, w, h, isActive = true) constructor {
	elements = _elements;
	step = function() {
		draw_set_color(c_Back);
		DrawRect();
		for(var i = 0 ; i < array_length(elements);i++) {
			//show_message(string(i) + "\n" + string(elements[i]) );
			with(elements[i]) {
				
				mousePosition = o_GUI.getMouse();
				mouseCheck = mouse_check_button_released(mb_left);
				inBounds = mousePosition[0] >= transform.x && mousePosition[0] <= transform.x + transform.width && mousePosition[1] >= transform.y && mousePosition[1] <= transform.y + transform.height;
				step();
			}
		}
	}
	static Add = function(element, _id = -1) {
		if(_id == -1) _id = array_length(elements);
		array_push(elements, {
			self : element,
			ID : _id,
		});
		element.ID = _id;
	}
	static Get = function(targetID) {
		for(var i = 0 ; i < array_length(elements);i++) {
			if(elements[i].ID == targetID) return elements[i].self;
		}
		return -1;
	}
	static DestroySelf = function() {
		for(var i = 0 ; i < array_length(elements);i++) {
			elements.onDestroy();
			array_delete(elements, i, 1);
		}
		o_GUI.getCurrentScreen().Destroy(ID);
	}
	//Add(new Button(transform.x + (tranform.width - 20), transform.y, 20, 20, function(){getCurrentScreen().Get(id).Toggle()}), "panel_exit");
}
function ObjectList(_x,_y,w,h, _objects, _pages, _listWidth, isActive = true) : Element(_x, _y, w, h, isActive) constructor {
	objects = _objects;
	listWidth = _listWidth;
	pages = _pages;
	currentPage = 0;
	step = function() {
		
		var TEXT_HEIGHT = 20;
		var OBJECT_X_DISPLACE = 100;
		var OBJECT_SIZE_X = 50;
		var OBJECT_SIZE_Y = 50;
		draw_set_color(c_Back);
		DrawRect();
		
		//Page stuff
		draw_set_color(c_white);
		draw_line(transform.x + OBJECT_X_DISPLACE, transform.y, transform.x + OBJECT_X_DISPLACE, transform.y + transform.height);
		draw_set_halign(fa_left);
		draw_set_valign(fa_bottom);

		
		draw_set_color(c_gray);
		draw_rectangle(transform.x, transform.y + (currentPage * TEXT_HEIGHT), transform.x + OBJECT_X_DISPLACE, transform.y + ( (currentPage+1) * TEXT_HEIGHT), false);
		
		var i = 0;
		var ignore = false;
		for(i = 0 ; i < array_length(pages);i++) {
			if(i == currentPage) draw_set_color(c_white);
			else draw_set_color(c_gray);
			draw_text(transform.x, transform.y + ((i+1) * TEXT_HEIGHT), pages[i]);
			if(mousePosition[0] >= transform.x && mousePosition[0] <= transform.x + OBJECT_X_DISPLACE && mousePosition[1] >= transform.y - (i * TEXT_HEIGHT) && mousePosition[1] <= transform.y + ((i+1) * TEXT_HEIGHT) && mouseCheck && !ignore) {
				ignore = true;
				currentPage = i;
			}
		}
		var xPos = 0;
		var yPos = 0;
		for(i = 0; i < array_length(objects[currentPage]);i++) {
			var s = object_get_sprite(objects[currentPage][i]);
			//draw_sprite(s, 0, (transform.x + OBJECT_X_DISPLACE) + (i * OBJECT_SIZE_X), transform.y + yPos );
			var test = transform.x + OBJECT_X_DISPLACE;
			//draw_rectangle(test - (i * OBJECT_SIZE_X), transform.y - (yPos * OBJECT_SIZE_Y), test + ((i+1) * OBJECT_SIZE_X), transform.y + ( (yPos+1) * OBJECT_SIZE_Y), false);
			if(mousePosition[0] >= test + (xPos* OBJECT_SIZE_X) && mousePosition[0] <= test + ((xPos+1) * OBJECT_SIZE_X) && mousePosition[1] >= transform.y + (yPos* OBJECT_SIZE_Y) && mousePosition[1] <= transform.y + ((yPos+1) * OBJECT_SIZE_Y)) {
				draw_set_color(c_gray);
				draw_rectangle(test + (xPos* OBJECT_SIZE_X), transform.y + (yPos * OBJECT_SIZE_Y), test + ((xPos+1) * OBJECT_SIZE_X), transform.y + ( (yPos+1) * OBJECT_SIZE_Y), false);
				if(mouseCheck && !ignore) {
					ignore = true;
					o_GUI_LevelEditor.currentObject = objects[currentPage][i];
				}
			}
			draw_sprite_pos(s, 0, test + (xPos* OBJECT_SIZE_X), transform.y + (yPos * OBJECT_SIZE_Y), test + ((xPos+1) * OBJECT_SIZE_X), transform.y + (yPos * OBJECT_SIZE_Y), test + ((xPos+1) * OBJECT_SIZE_X), transform.y + ((yPos+1) * OBJECT_SIZE_Y), test + (xPos* OBJECT_SIZE_X), transform.y + ((yPos+1) * OBJECT_SIZE_Y), 1 );
			draw_set_color(c_white);
			//draw_text(test + (xPos * OBJECT_SIZE_X), transform.y + ((yPos+1) * OBJECT_SIZE_Y), StrCat(xPos, yPos));
			xPos++;
			if(xPos >= listWidth) {
				xPos = 0;
				yPos++;
			}
			
		}
	}
	/*
	onToggle = function() {
		if(!active) {
			with(o_GUI_LevelEditor) {
				currentObject = noone;
				editorLayer = EditorLayers.None;
			}
		}
	}
	*/
}
function TextBox(_x,_y,w,h, _output = function(){}, _maxChar = 20, _prompt = "", isActive = true) : Element(_x,_y,w,h,isActive) constructor {
	isTyping = false;
	type = 0; // 0 - any, 1 - string, 2 - numbers
	maxChar = _maxChar;
	output = _output;
	prompt = o_GUI.resizeTextByNewLine(transform.width, _prompt);
	step = function() {
		draw_set_color(c_white);
		var divi = [transform.width / 2, transform.height / 2];
		draw_rectangle(transform.x - divi[0], transform.y - divi[0], transform.x + divi[0], transform.y + divi[0], true);
		if(mousePosition[0] >= transform.x - divi[0] && mousePosition[0] <= transform.x + divi[0] && mousePosition[1] >= transform.y - divi[1] && mousePosition[1] <= transform.y + divi[1] && mouseCheck) {
			isTyping = true;
			keyboard_string = "";
		}
		if(isTyping) {
			draw_text(transform.x, transform.y, keyboard_string);
			if(keyboard_check_pressed(vk_enter)) isTyping = false;
		}
	}
	onDestroy = function() {
		var _out = keyboard_string;
		if(type == 1) _out = string_replace(keyboard_string, string_digits(keyboard_string), ""); //Is this hacky?
		if(type == 2) _out = real(keyboard_string);
		output(_out);
		keyboard_string = "";
	}
}
function VariableEditor(_x,_y,w,h, ref, targType, isActive = true) : Element(_x,_y,w,h,isActive) constructor {
	targetVar = ref;
	targetType = targType; // 0 - object 1 - struct
	editVar = -1;
	step = function() {
		draw_set_color(c_Back);
		DrawRect();
		draw_set_color(c_white);
		if(targetVar == -1 || targetType == -1) show_error("Invalid ref/target type!", true);
		var targetStuff = targetType == 0 ? variable_instance_get_names(targetVar) : variable_struct_get_names(targetVar);
		for(var i = 0 ; i < array_length(targetStuff);i++) {
			draw_text(transform.x, transform.y + (i * 20), targetStuff[i] + ": " + string((targetType == 0 ? variable_instance_get(targetVar, targetStuff[i]) : variable_struct_get(targetVar, targetStuff[i])) ) );
			if(mousePosition[0] >= transform.x && mousePosition[0] <= transform.x + transform.width && mousePosition[1] >= transform.y - (i * 20) && mousePosition[1] <= transform.y + ((i + 1) * 20) && mouseCheck) {
				with(o_GUI) { //I hate gml structs, it only knows itself...
					getCurrentScreen().Add(new TextBox(100, 100, 400, 400));
				}
				editVar = 0;
			}
		}
	}
}
function MessageBox(_x,_y,w,h, _message, isActive = true) : Element(_x,_y,w,h,isActive) constructor {
	prompt = o_GUI.resizeTextByNewLine(transform.width, _message); //Fuck you
	step = function() {
		var divi = [transform.width / 2, transform.height / 2];
		draw_set_color(c_Back);
		draw_rectangle(transform.x - divi[0], transform.y - divi[1], transform.x + divi[0], transform.y + divi[1], false);
		draw_set_color(c_white);
		draw_set_halign(fa_center);
		draw_text(transform.x + divi, transform.y + (divi - 100), prompt);
	}
	//with(o_GUI) getCurrentScreen().Add(new Button(other.transform.x, other.transform.y + 75, 25, 25, function(){o_GUI.getCurrentScreen().Destroy(ID)}, "Ok!" ));
}
