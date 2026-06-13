var buildText = "Beta Version " + string(GM_version);
//buildText = "Pre-Beta Version 2.0";

texturegroup_load("tgMainMenu", true);

text = buildText + @" of PT:M

Hello again!

This time, the game is in an incredible state. First of all, we have major performance improvements.


Default Controls:
Z-Jump, X-Dash, Enter-Pause, Arrow Keys-Move, Tab-Noclip
Press Enter to continue.";

/*Styles
 * 0 - Normal
 * 1 - Blast into
 * 2 - Delay, then fade in
*/
//style = irandom_range(0, 1);
style = 1;
currentText = "";
if(style == 1) {
	//Playing a sound makes this useful now :)
	image_xscale = 0;
	image_yscale = 0;
	alarm[0] = 1;
}
textDelay = 0;
draw_set_color(c_white);
draw_set_font(ComicSans);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
keys = [vk_up, vk_up, vk_down, vk_down, vk_left, vk_right, vk_left, vk_right, ord("X"), ord("Z"), vk_enter];
keyI = 0;
/*
var b = audio_group_load(AG_Music);
if(!b) {
    
    var q = show_question("Failed to load audio group (AG_Music)!\nDo you want to quit the game (yes), or continue without audio? (no)");
    if(q) {
        game_end(1);
    }
    else {
        instance_destroy(o_MusicManager);
        global.settings.audio.muteAll = true;
        
    }
    
}
*/