event_inherited();
if(!thrown && other.state != "bomb" && state != "throw") {
	setState("throw");
	thrown = true;	
}