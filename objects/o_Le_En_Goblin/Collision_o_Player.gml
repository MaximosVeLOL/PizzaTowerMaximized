event_inherited();
if(!thrown && (state == "walk" || state == "idle" || state == "turn")) {
	setState("throw");
	image_xscale = other.xscale;
}