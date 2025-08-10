text = "Beta Version " + string(GM_version) + @" of PT:M

Welcome to another beta build!
This time, there is much more new content to see. But also,


Controls:
Z-Jump, X-Dash, Enter-Pause, Arrow Keys-Move, Tab-Noclip
Press Enter to continue.";
currentText = "";
textDelay = 0;
draw_set_color(c_white);
draw_set_font(ComicSans);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
keys = [vk_up, vk_up, vk_down, vk_down, vk_left, vk_right, vk_left, vk_right, ord("X"), ord("Z"), vk_enter];
keyI = 0;