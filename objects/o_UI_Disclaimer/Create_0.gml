var buildText = "Beta Version " + string(GM_version);
buildText = "Beta Version 1.5";



text = buildText + @" of PT:M

Welcome to another beta build!
This time, there is much more new content to see. Some of the big ones being:

Parralax Backgrounds (scaling is broken for some reason)
Level Editor (Still being worked on...)


Controls:
Z-Jump, X-Dash, Enter-Pause, Arrow Keys-Move, Tab-Noclip
Press Enter to continue.";

text = buildText + @"of PT:M

This game is dying! There were big ideas for this fangame,
but most have been scrapped in this build. (multiplayer, parralax backgrounds, a level editor)
The only new content that is exciting in this build, is some new slopes, and Pre-ETB's level 1.
Most scrapped things are eventually going to return in future builds. Now, lets enjoy the only
good stuff in this build: a new level.

"


currentText = "";
textDelay = 0;
draw_set_color(c_white);
draw_set_font(ComicSans);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
keys = [vk_up, vk_up, vk_down, vk_down, vk_left, vk_right, vk_left, vk_right, ord("X"), ord("Z"), vk_enter];
keyI = 0;