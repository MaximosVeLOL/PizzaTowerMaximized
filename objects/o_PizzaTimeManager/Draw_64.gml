var text = "";
var minutes = floor(o_GameManager.level.time / 60);
var seconds = round(o_GameManager.level.time % 60);
//Avoid doing calculations again? I don't know if thats how computers work.

text += minutes < 1 ? "0" : string(minutes);
text += seconds < 10 ? ":0" + string(seconds) : ":" + string(seconds);



draw_set_halign(fa_center);
draw_set_font(global.misc.font);
draw_text(480, 65, text);
GUI_RESET;