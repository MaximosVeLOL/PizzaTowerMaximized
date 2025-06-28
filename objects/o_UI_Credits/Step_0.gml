if(y < -string_height(text) || keyboard_check(vk_anykey) || GetInput("dash") ) {
	instance_deactivate_object(self);
	instance_activate_object(o_UI_MainMenu);
}