var bID = [
	"Up",
	"Down",
	"Left",
	"Right",
	"Jump",
	"Dash",
	"Shoot",
	"Pause"
];
for(var i = 0; i < array_length(allButtons);i++) {
	draw_set_color((keyboard_check(bToInput[allButtons[i].ID]) ? c_gray : c_white));
	draw_circle(allButtons[i].position.x, allButtons[i].position.y, allButtons[i].radius, false);
	draw_set_color(c_black);
	draw_circle(allButtons[i].position.x, allButtons[i].position.y, allButtons[i].radius, true);
	
	draw_text(allButtons[i].position.x, allButtons[i].position.y, bID[allButtons[i].ID]);
}
GUI_RESET;