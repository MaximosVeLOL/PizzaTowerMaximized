var buildText = "Beta Version " + string(GM_version);
buildText = "Pre-Beta Version 2.0";



text = buildText + @" of PT:M

Welcome to another beta build!
This fangame was so close to dying. First of all, there were many big things to implement:
A Level Editor, Multiplayer, and Online. But then I realized I was wasting too much time,
So I decided to remove most of the features, and focus on the important things. So that's
why theres a lot of bug fixes. Anyways, heres some of the big features that are implemented:

Parralax Backgrounds
The Pre-ETB moveset
Ranking System (Its hard to control so many things at once)


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