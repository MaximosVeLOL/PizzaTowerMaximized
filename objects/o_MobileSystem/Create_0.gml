enum ButtonID {
	Up,
	Down,
	Left,
	Right,
	Jump,
	Dash,
	Shoot,
	Pause,
};
allButtons = [];

createButton = function(p_Position, p_ID, p_Radius) {
	array_push(allButtons, {
		position : p_Position,
		ID : p_ID,
		radius : p_Radius,
		pressed : false,
	});
};
#macro TOUCH_COUNT 5
allTouches = array_create(TOUCH_COUNT, new Vector(-1, -1));
var defY = 380;
createButton(new Vector(140, defY - 60), ButtonID.Up, 40);
createButton(new Vector(140, defY + 60), ButtonID.Down, 40);
createButton(new Vector(60, defY), ButtonID.Left, 40);
createButton(new Vector(220, defY), ButtonID.Right, 40);
createButton(new Vector(960 - 60, defY), ButtonID.Jump, 40);
createButton(new Vector(960 - 220, defY), ButtonID.Dash, 40);
createButton(new Vector(960 - 40, 40), ButtonID.Pause, 20);
bToInput = [
	global.settings.keyBinds.p0.up,
	global.settings.keyBinds.p0.down,
	global.settings.keyBinds.p0.left,
	global.settings.keyBinds.p0.right,
	global.settings.keyBinds.p0.jump,
	global.settings.keyBinds.p0.dash,
	global.settings.keyBinds.p0.shoot,
	vk_printscreen,
	//"misc1",
	//misc2
];

onPress = function(p_Device) {
	for(var b = 0; b < array_length(allButtons);b++) {
		//Log(string(i));
		var button = allButtons[b];
		var inPoint = point_in_circle(allTouches[p_Device].x, allTouches[p_Device].y, button.position.x, button.position.y, button.radius);

		var input = bToInput[button.ID];
		if(inPoint) {
			if(allButtons[b].ID == ButtonID.Pause) {
				o_GameManager.pauseGame();
				break;
			}
			keyboard_key_press(input);
			button.pressed = true;
			break;
		}
		//This should not be reached when inPoint is true
		//button.pressed fixes the issue of actual keyboard inputs being cancelled
		if(button.pressed) {
			button.pressed = false;
			keyboard_key_release(input);
		
		}
	}
}