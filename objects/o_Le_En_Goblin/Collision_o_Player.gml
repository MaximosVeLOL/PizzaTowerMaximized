event_inherited();
if(!thrown && (other.state == "walk" || other.state == "idle" || other.state == "turn")) {
	setState("throw");
	image_xscale = other.xscale;
}