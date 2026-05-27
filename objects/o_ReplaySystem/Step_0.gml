switch(mode) {
	case 0:
	
	break;
	
	case 1:
		if(keyboard_check(vk_anykey)) {
			if(array_length(inputs) > 0 && keyboard_key == array_last(inputs).key)
				array_last(inputs).time++;
			else {
				array_push(inputs, new Input(keyboard_key));
			}
		}
		else {
			if(array_length(inputs) > 0 && array_last(inputs).key == vk_nokey)
				array_last(inputs).time++;
			else {
				array_push(inputs, new Input(vk_nokey));
			}
		}
	break;
	
	case 2:
		if(waitTime < inputs[inputIndex].time) {
			waitTime++;
		}
		else {
			waitTime = 0;
			keyboard_key_release(inputs[inputIndex].key);
			inputIndex++;
			if(inputIndex >= array_length(inputs)) {
				mode = 0;
				LogError("Done!");
				inputs = [];
				gc_collect();
				return;
			}
			keyboard_key_press(inputs[inputIndex].key);
		}
	break;
}

if(keyboard_check_pressed(vk_alt)) {
	mode = (mode == 1 ? 2 : 1);
	if(mode == 1) {
		startingCondition = {
			position : new Vector(o_Player.x, o_Player.y),
			room : room	
		};
	}
	else {
		inputIndex = 0;
		waitTime = 0;
		keyboard_key_press(inputs[0].key);
		o_Player.x = startingCondition.position.x;
		o_Player.y = startingCondition.position.y;
		room_goto(startingCondition.room);
	}
}