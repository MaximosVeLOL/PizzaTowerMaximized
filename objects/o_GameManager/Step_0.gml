timer += (1/game_get_speed(gamespeed_fps));
if(keyboard_check_pressed(vk_escape) && !instance_exists(o_UI_PauseMenu)) instance_create_depth(0,0,0,o_UI_PauseMenu);