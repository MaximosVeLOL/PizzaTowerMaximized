var checkSuccess = false;
/*
var targetObjects = []; //Objects that will instantly trigger the check without any other conditions

for(var i = 0 ; i < array_length(targetObjects);i++) {
	if(place_meeting(x,y, targetObjects[i])) {
		checkSuccess = true;
		break;
	}
}

None of the objects to check for (eg. chainsaw, bullets) are implemented yet. So we don't need this.
*/

if(sprite_index == sprite_level_pizzabox) {
	if(place_meeting(x,y,o_PlayerParent)) {
		with(instance_place(x,y,o_PlayerParent)) {
			if((state == "freefall" || (state == "jump" || state == "highjump") && GetInput("jump", 0, PD)) && velocity[1] > 0) {
				other.open();
				setState("jump");
				velocity[1] = -14;
				tempVar[1] = true;
			}
		}
	}
}
else {
	if(round(image_index) == 4) instance_create_depth(x - 32,y - 64,0,o_Le_BigPoints);
	if(round(image_index) == image_number) instance_destroy();
}