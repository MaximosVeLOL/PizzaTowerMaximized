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

if(sprite_index != sprite_level_pizzabox) {
    if(round(image_index) == 4)
        instance_create_depth(x - 32,y - 64,0,o_Le_BigPoints);
	else if(IMAGE_COMPLETE)
        instance_destroy();
    return;
}
var inst = instance_place(x,y,o_Player);
if(inst != noone) {
    with(inst) {
        if((state == PlayerState.Freefall || (state == PlayerState.Jump || state == PlayerState.HighJump) && GetInput("jump", 0)) && velocity.y > 0) {
            other.open();
            if(state == PlayerState.Freefall) {
                tempVar[0] = 0; //State
                tempVar[1] = 0; //Timer
                animVar = true; //Hit animation
                image_index = 0;
                velocity.y = -7;
            }
            else {
                setState(PlayerState.Jump);
                velocity.y = -14;
                tempVar[1] = true;
            }
        }
    }
}
