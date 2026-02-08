var toolTips = [
	"Position: " + string(offset[0]) + ", " + string(offset[1]),
	"Object Selected: " + (selectedObject != noone ? object_get_name(selectedObject) : "None"),
	"Mode: " + mode,
];
draw_set_halign(fa_right);
for(var i = 0 ; i < array_length(toolTips);i++) {
	draw_text(940, 20 + (i * 20), toolTips[i]);
}
GUI_RESET;