if(instance_exists(o_DEBUG_Console) && o_DEBUG_Console.settings.renderCollision) {
	depth = -999;
	image_alpha = 0.5;
	visible = true;
}
else if(object_index != o_Le_RedGuy || object_index != o_B_Parent ) visible = false;