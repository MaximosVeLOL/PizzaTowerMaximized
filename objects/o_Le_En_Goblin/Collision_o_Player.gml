event_inherited();
if(!thrown && other.state != "bomb" && state != "throw") {
	setState("throw");
	image_xscale = other.xscale;
}