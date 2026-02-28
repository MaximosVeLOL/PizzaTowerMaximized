draw_set_font(ComicSans);
draw_set_color(c_white);
var toolTips = [
	"Position: " + string(offset[0]) + ", " + string(offset[1]),
	"Object Selected: " + (selectedObject != noone ? object_get_name(selectedObject) : "None"),
	"Mode: " + mode,
];
draw_set_halign(fa_right);
for(var i = 0 ; i < array_length(toolTips);i++) {
	draw_text(940, 20 + (i * 20), toolTips[i]);
}
if(notification[0]) {
	draw_text(940, 515, "Auto saved!");
	notification[1] -= TIME_BASE;
	notification[0] = notification[1] >= 0;
	if(notification[1] <= 0.5) 
		alarm[0] = (60 ^ 2) * 5;
}
GUI_RESET;