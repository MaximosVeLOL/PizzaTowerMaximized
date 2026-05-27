draw_set_color(c_aqua);
with(all) {
	draw_text(x, y, "ID: " + string(id) + "\nInstance ID: " + string(instance_id[id]));
}
GUI_RESET;