//Currently, rects are aligned to the top left!!!


function GUI_Vector2(_x = 0, _y = 0) constructor {
	x = _x;
	y = _y;
}

function GUI_IsTouchingRect(targetRect, _x, _y) {
	return (_x > targetRect.x && _x <= targetRect.x + targetRect.width && _y >= targetRect.y && _y <= targetRect.y + targetRect.height);
	
}

function GUI_FindObject(GUIHandler, objectName) {
	var j = 0;
	for(var i = 0 ; i < array_length(GUIHandler.allObjects);i++) {
		var currentObject = GUIHandler.allObjects[i];
		if(currentObject.name == objectName) return currentObject;
		if(array_length(currentObject.children) > 0) {
			for(j = 0; j < array_length(currentObject.children);j++) {
			}
		}
	}
}

function GUI_DrawCustomRect(inRect) {
	draw_rectangle(inRect.x, inRect.y, inRect.x + inRect.width, inRect.y + inRect.height, false);
	
	if(global.GUIStyle.useOutline) {
		draw_set_color(global.GUIStyle.c_Outline);
		draw_rectangle(inRect.x, inRect.y, inRect.x + inRect.width, inRect.y + inRect.height, true);
	}
}


function GUI_Rect(_x = 0, _y = 0, w = 0, h = 0) : GUI_Vector2(_x, _y) constructor {
	width = w;
	height = h;
	static GetPosition = function() {
		return new GUI_Vector2(x, y);
	}
	static GetSize = function() {
		return new GUI_Vector2(width, height);
	}
}

function GUI_Style() constructor {
	/*
	c_Background = c_white;
	c_Outline = c_black;
	c_Highlight = c_gray;
	c_Text = c_black;
	c_Selected = c_green;
	font = -1; //-1 = default font
	useOutline = true;
	*/
	c_Background = c_black;
	c_Outline = c_white;
	c_Highlight = c_gray;
	c_Text = c_white;
	c_Selected = c_green;
	font = -1; //-1 = default font
	useOutline = true;
}

function GUI_Component(_name, _rect = new GUI_Rect(), isActive = true) constructor {
	parentObject = NULL;
	active = isActive;
	name = _name;
	rect = _rect;
	
	static SetObjectParent = function(inObject) {
		parentObject = inObject;
	}
	
	static DrawParentRect = function(overrideBGColor = true, useOutline = global.GUIStyle.useOutline) {
		if(parentObject == NULL) return;
		
		with(parentObject) {
			if(!overrideBGColor) draw_set_color(global.GUIStyle.c_Background);
			draw_rectangle(rect.x, rect.y, rect.x + rect.width, rect.y + rect.height, false);
			if(useOutline) {
				draw_set_color(global.GUIStyle.c_Outline);
				draw_rectangle(rect.x, rect.y, rect.x + rect.width, rect.y + rect.height, true);
			}
		}
	}
	static DrawRect = function(overrideBGColor = true, useOutline = global.GUIStyle.useOutline) {
		if(!overrideBGColor) draw_set_color(global.GUIStyle.c_Background);
		draw_rectangle(rect.x, rect.y, rect.x + rect.width, rect.y + rect.height, false);
		if(useOutline) {
			draw_set_color(global.GUIStyle.c_Outline);
			draw_rectangle(rect.x, rect.y, rect.x + rect.width, rect.y + rect.height, true);
		}
	}
	static DrawRectBoth = function(overrideBGColor = true, useOutline = global.GUI.useOutline) {
		var pRect = parentObject.rect;
		
		if(!overrideBGColor) draw_set_color(global.GUIStyle.c_Background);
		draw_rectangle(pRect.x + rect.x, pRect.y + rect.y, pRect.x + rect.x + rect.width, pRect.y + rect.y + rect.height, false);
		if(useOutline) {
			draw_set_color(global.GUIStyle.c_Outline);
			draw_rectangle(pRect.x + rect.x, pRect.y + rect.y, pRect.x + rect.x + rect.width, pRect.y + rect.y + rect.height, true);
		}
	}
	static IsMouseOverRect = function() {
		return window_mouse_get_x() >= parentObject.rect.x && window_mouse_get_x() <= parentObject.rect.x + parentObject.rect.width && window_mouse_get_y() >= parentObject.rect.y && window_mouse_get_y() <= parentObject.rect.y + parentObject.rect.height;
	}
	create = function(){};
	step = function(){};
	destroy = function(){};
	
	static Toggle = function() {
		active = !active;
	}
}

function GUI_Object(_name, _rect = new GUI_Rect(), _components = [], _children = [], isActive = true) constructor {
	name = _name;
	rect = _rect;
	active = isActive;	
	
	children = _children;
	
	
	components = _components;
	
	static Exectute = function() {
		if(!active) return;
		var i;
		for(i = 0 ; i < array_length(components);i++) {
			var actualSelf = self;
			if(!components[i].active) continue;
			with(components[i]) {
				
				if(parentObject == NULL) {show_debug_message("Set the parent object!");parentObject = actualSelf;} //Temporary
				step();
			}
		}
		if(array_length(children) > 0) {
			for(i = 0 ; i < array_length(children);i++) {
				children[i].Execute();
			}
		}
	}
	
	static AddChild = function(object) {
		array_push(children, object);
	}
	static AddComponent = function(inComponent) {
		array_push(components, inComponent);
		return components[array_length(components) - 1];
	}
	static GetComponent = function(name) {
		for(var i = 0 ; i < array_length(components);i++) {
			if(components[i].name == name) return components[i];
		}
		return NULL;
	}
	static GetObject = function(name) {
		for(var i = 0 ; i  < array_length(children);i++) {
			if(children[i].name == name) return children[i];
		}
		return NULL;
	}
	
	static Toggle = function() {
		active = !active;
	}
}


#region Components

function GUI_Component_Text(_text) : GUI_Component("text") constructor {
	text = _text;
	step = function() {
		draw_set_font(global.GUIStyle.font);
		draw_set_color(global.GUIStyle.c_Text);
		//show_debug_message(rect);
		draw_text(parentObject.rect.x + rect.x, parentObject.rect.y + rect.y, text);
	}
}
function GUI_Component_Button(_onClick) : GUI_Component("button") constructor {
	
	onClick = _onClick;
	
	step = function() {
		draw_set_color(global.GUIStyle.c_Background);
		if(IsMouseOverRect()) {
			draw_set_color(global.GUIStyle.c_Highlight);
			if(mouse_check_button_pressed(mb_left)) onClick();
		}
		DrawParentRect();
	}
}


function GUI_Component_List(_elements, _rect = new GUI_Rect(), _onChange = function(){} ) : GUI_Component("List", _rect) constructor {
	elements = _elements;
	elementHeight = -1;
	onChange = _onChange;
	index = 0;
	rect = _rect;
	
	step = function() {
		var check = false;
		var parentRect = parentObject.rect;
		if(elementHeight == -1) elementHeight = rect.height / array_length(elements);
		for(var i = 0 ; i < array_length(elements);i++) {
			
			//show_debug_message(parentObject);
			//show_debug_message("ElementHeight: " + string(elementHeight));

			draw_set_color(global.GUIStyle.c_Background); //Waste of CPU cycles???
			if(i == index) draw_set_color(global.GUIStyle.c_Selected); //All those checks wasted for nothing........11
			if(window_mouse_get_x() >= parentRect.x &&  window_mouse_get_x() <= parentRect.x + rect.width && window_mouse_get_y() >= parentRect.y + (i * elementHeight) && window_mouse_get_y() <= parentRect.y + ( (i+1) * elementHeight)) {
				draw_set_color(global.GUIStyle.c_Highlight);
				if( mouse_check_button_pressed(mb_left) && !check) {
					check = true;
					index = i;
					onChange(parentObject, i); //This does exist, GML is just crazy???
				}
			}
			//GUI_DrawCustomRect(new GUI_Rect(parentRect.x, parentRect.y, parentRect.width, elementHeight));
			draw_rectangle(parentRect.x, parentRect.y + (i * elementHeight), parentRect.x + rect.width, parentRect.y + ((i+1) * elementHeight), false);
			draw_set_color(global.GUIStyle.c_Outline);
			draw_rectangle(parentRect.x, parentRect.y + (i * elementHeight), parentRect.x + rect.width, parentRect.y + ((i+1) * elementHeight), true);
			
			draw_set_color(global.GUIStyle.c_Text);
			draw_text(parentRect.x, parentRect.y + (i * elementHeight), string(elements[i]) );
		}
		//draw_rectangle(parentRect.x, parentRect.y, parentRect.x + parentRect.width, parentRect.y + parentRect.height, true);
	}
}
function GUI_Component_ObjectList(_elements, _maxHElements, _pageComponent = NULL) : GUI_Component("ObjectList") constructor { //Should we build this off of the other stuff?
	elements = _elements;
	maxHElements = _maxHElements;
	index = 0;
	pageComponent = {index : 0};
	rect = new GUI_Rect(100, 0, 0, 0);
	
	step = function() {
		draw_set_color(global.GUIStyle.c_Background);
		DrawParentRect();
		//if(pageComponent == NULL) return;
		if(pageComponent == NULL) {
			show_debug_message("Trying to get the list bruh");
			pageComponent = parentObject.GetComponent("list")
		}
		var IMAGE_SIZE = 32;
		var position = new GUI_Vector2(0,0);
		var check = false;
		for(var i = 0; i < array_length(elements[pageComponent.index]);i++) {
			var current = elements[pageComponent.index][i];
			var currentObjectSprite = object_get_sprite(current);
			var pRect = parentObject.rect;
			//draw_sprite(currentObjectSprite, -1, pRect.x + rect.x + (position.x * IMAGE_SIZE), pRect.y + rect.y + (position.y * IMAGE_SIZE));
			draw_sprite_pos(currentObjectSprite, -1, pRect.x + rect.x + (position.x * IMAGE_SIZE), pRect.y + rect.y + (position.y * IMAGE_SIZE), pRect.x + rect.x + ((position.x + 1) * IMAGE_SIZE), pRect.y + rect.y + (position.y * IMAGE_SIZE), pRect.x + rect.x + ( (position.x+1) * IMAGE_SIZE), pRect.y + rect.y + ((position.y + 1) * IMAGE_SIZE), pRect.x + rect.x + (position.x * IMAGE_SIZE), pRect.y + rect.y + ((position.y + 1) * IMAGE_SIZE), 1);
			var mouse = new GUI_Vector2(window_mouse_get_x(), window_mouse_get_y());
			//draw_rectangle(pRect.x + rect.x + (position.x * IMAGE_SIZE), pRect.y + rect.y + (position.y * IMAGE_SIZE), pRect.x + rect.x + ((position.x + 1) * IMAGE_SIZE), pRect.y + rect.y + ((position.y + 1) * IMAGE_SIZE), false);
			if(mouse.x >= pRect.x + rect.x + (position.x * IMAGE_SIZE) && mouse.x <= pRect.x + rect.x + ((position.x+1) * IMAGE_SIZE) && mouse.y >= pRect.y + rect.y + (position.y * IMAGE_SIZE) && mouse.y <= pRect.y + rect.y + ((position.y+1) * IMAGE_SIZE)) {
				if(mouse_check_button_pressed(mb_left) && !check) {
					check = true;
					index = i;
					o_MUI_LevelEditor.currentObject = current;
				} 
			}
			position.x++;
			if(position.x >= maxHElements) {
				position.x = 0;
				position.y++;
			}
		}
	}
	
}
function GUI_Component_TextInput(_characterType, _rect = parentObject.rect, defaultInput = "t", _maxCharacters = -1, _onComplete = function(){}) : GUI_Component("TextInput", _rect) constructor {
	textComponent = NULL;
	buttonComponent = NULL;
	
	characterType = _characterType == "t" || _characterType == "n" ? _characterType : "t"; // t - text, n - num
	
	input = defaultInput;
	inputIndex = 0;
	maxCharacters = _maxCharacters;
	
	pleaseTypeDelay = 1;
	
	
	typing = false;
	
	onComplete = _onComplete;
	
	step = function() {
		draw_set_color(global.GUIStyle.c_Background);
		if(GUI_IsTouchingRect(rect, window_mouse_get_x(), window_mouse_get_y()))  {
			draw_set_color(global.GUIStyle.c_Highlight);
			if(mouse_check_button_pressed(mb_left)) typing = true;
		}
		if(typing) draw_set_color(global.GUIStyle.c_Selected);
		//DrawParentRect();
		draw_rectangle(parentObject.rect.x + rect.x, parentObject.rect.y + rect.y, parentObject.rect.x + rect.x + rect.width, parentObject.rect.y +  rect.y + rect.height, false);
		if(typing) {
			inputIndex += (keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left));
			inputIndex = clamp(inputIndex, 0, maxCharacters);
			if(input != keyboard_string) pleaseTypeDelay = 1;
			input = characterType == "t" ? keyboard_string : string_digits(keyboard_string); //M_OPTI - Is this good???
			if(keyboard_check_pressed(vk_enter)) {
				typing = false;
				onComplete(input);
			}
			pleaseTypeDelay -= (1 / game_get_speed(gamespeed_fps));
			if(pleaseTypeDelay <= 0) pleaseTypeDelay = 1;
			//if(keyboard_check_pressed(vk_backspace)) input = string_copy(input, 0, inputIndex);
		}
		draw_set_color(global.GUIStyle.c_Text);
		draw_text(parentObject.rect.x + rect.x, parentObject.rect.y + rect.y, MinimizeTextWithNewLines(input + (pleaseTypeDelay <= 0.5 ? "|" : ""), parentObject.rect.width) );
		
	}
}
function GUI_Component_TilesetViewer(_data, _rect) : GUI_Component("TilesetViewer", _rect) constructor {
	data = _data;
	currentTileset = _data[0]; //M_OPTI - Do we need this?
	
	currentTilesetTexture = -1;
	step = function() {
		draw_set_color(global.GUIStyle.c_Background);
		DrawParentRect();
		if(currentTilesetTexture != -1) {
			//currentTilesetTexture = tileset_get_texture(listComponent.elements[listComponent.index]);
			var pRect = parentObject.rect;

			
			draw_primitive_begin_texture(pr_trianglestrip, currentTilesetTexture);
			draw_vertex_texture(pRect.x + rect.x, pRect.y + rect.y, 0, 0);
			draw_vertex_texture(pRect.x + rect.x + texture_get_width(currentTilesetTexture), pRect.y + rect.y, 1, 0);
			draw_vertex_texture(pRect.x + rect.x, pRect.y + rect.y + texture_get_height(currentTilesetTexture), 0, 1);
			draw_vertex_texture(pRect.x + rect.x + texture_get_width(currentTilesetTexture), pRect.y + rect.y + texture_get_height(currentTilesetTexture) , 1, 1);
			draw_primitive_end();
			
			var position = new GUI_Vector2(pRect.x + rect.x, pRect.y);
			while(position.x < pRect.x + rect.x + (pRect.width - 20) ) {
				draw_line(pRect.x + rect.x + position.x, pRect.y, pRect.x + rect.x + position.x, pRect.y + pRect.height);
				position.x += 32;
			}
			while(position.y < pRect.y + (pRect.height - 2)) {
				draw_line(pRect.x + rect.x, pRect.y + position.y, pRect.x + pRect.width,  pRect.y + position.y );
				position.y += 32;
			}
			
			if(IsMouseOverRect() && mouse_check_button_pressed(mb_left) && window_mouse_get_x() >= pRect.x + rect.x) {
				var realPos = new GUI_Vector2(window_mouse_get_x() - (pRect.x + rect.x), window_mouse_get_y() - pRect.y);
				show_message(string(round(realPos.x / 32) * 32) + ": " + string(round(realPos.y / 32) * 32));
			}
			/*draw_vertex_texture(0, 0, 0, 0);
			draw_vertex_texture(640, 0, 1, 0);
			draw_vertex_texture(0, 480, 0, 1);
			draw_vertex_texture(640, 480, 1, 1);
			draw_primitive_end();*/
		}
		
	}
	
}



function GUI_Component_Bar() : GUI_Component("Bar") constructor {
	step = function() {
		var pRect = parentObject.rect;
		//draw_rectangle(pRect.x + rect.x, pRect.y + rect.y + pRect)
	}
}


#endregion


#region Object Presets

function CreateButton(pos, name, text, _onClick, isActive = true) {
	var object = new GUI_Object(name, pos, [], [], isActive );
	object.AddComponent(new GUI_Component_Button(_onClick));//.rect = new GUI_Rect(pos.width / 2, pos.height / 2, 0, 0);
	object.AddComponent(new GUI_Component_Text(text));
	
	return object;
}
function CreateList(pos, name, elements, _onChange = function(){}, isActive = true) {
	 return new GUI_Object(name, pos, [new GUI_Component_List(elements, _onChange) ], [], isActive);
	
}
function CreateObjectList(pos, name, pageElements, objectElements, maxHElements, isActive = true) {
	var object = new GUI_Object(name, pos, [new GUI_Component_ObjectList(objectElements, maxHElements), new GUI_Component_List(pageElements, new GUI_Rect(0,0,100,75)) ], [], isActive);
	object.GetComponent("ObjectList").pageComponent = object.GetComponent("List");
	return object;
}
function CreateTextInput(pos, name, inputType = -1, maxCharacters = 255, defaultText = "", onComplete = function(){}, isActive = true) {
	var object = new GUI_Object(name, pos, [new GUI_Component_TextInput(inputType, pos, defaultText, maxCharacters, onComplete), new GUI_Component_Text(defaultText)], [], isActive);
	object.GetComponent("TextInput").textComponent = object.GetComponent("Text");
	return object;
}
function CreateTilesetViewer(pos, name, inListElements, isActive = true) {
	var object = new GUI_Object(name, pos, [new GUI_Component_TilesetViewer([tileset_tower, tileset_outside, tileset_city, tileset_secret], new GUI_Rect(100, 0, 0, 0)), new GUI_Component_List(inListElements, new GUI_Rect(0,0,100,50)) ], [], isActive);
	object.GetComponent("List").onChange = function(parent, index) {
		with(parent.GetComponent("TilesetViewer")) {
			currentTilesetTexture = tileset_get_texture(data[index]);
			//currentTilesetTexture = data[index]; Uncomment this if you wanna see cool textures!!!
		}
	
	};
	
	object.GetComponent("TilesetViewer").listComponent = object.GetComponent("List");
	return object;
}

#endregion
