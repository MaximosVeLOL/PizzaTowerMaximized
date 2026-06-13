event_inherited();
if(currentScreen == 0) {
    var moveX = GetInput("right", 1) - GetInput("left", 1);
    if(moveX == 0) moveX = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);
    return;
}
if(keyboard_check(vk_anykey)) {
    var bind = variable_struct_get(global.settings.keyBinds, "p" + string(profile));
    variable_struct_set(bind, names[targetKey], keyboard_key);
    io_clear();
    setScreen(0);
}