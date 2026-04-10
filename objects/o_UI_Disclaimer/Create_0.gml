var buildText = "Beta Version " + string(GM_version);
//buildText = "Pre-Beta Version 2.0";



text = buildText + @" of PT:M

We are back!
This fangame died. Luckily, I was inspired to retry again, after many bad decisions that
killed the game. Here are some things are finally implemented, albeit not perfect, most 
likely due to time constraints or technical limitations:

Level Select (Nobody wanted this)
Level Editor (Unfinished, time constraints & technical limitations)
Multiplayer (Not perfect, I don't know what to add to this)
Online mode (Not perfect, implemented in a few minutes)

I wanted to improve the big features, but I don't know what to add to them, and the
features I wanted to add were gonna take super long to implement. So, hopefully, I
will be able to add the features I want in the next upcoming months or weeks.


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