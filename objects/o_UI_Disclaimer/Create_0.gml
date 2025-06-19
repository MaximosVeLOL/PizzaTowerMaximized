text = @"
Beta Version 0.1 of PT:M

Welcome to the beta build.
Currently, I commited some time for bugfixing, adding new features for the player,
menus, and controller support.In the future, I will focus on add some more levels.
But my main focus is on adding a level editor.
Enemies in general should work better, and Peppino should be working as good now.


Controls:
Z-Jump, X-Dash, Enter-Pause, Arrow Keys-Move, Tab-Noclip
Press Enter to continue";
currentText = "";
textDelay = 0;

keys = [vk_up, vk_up, vk_down, vk_down, vk_left, vk_right, vk_left, vk_right, ord("X"), ord("Z"), vk_enter];
keyI = 0;