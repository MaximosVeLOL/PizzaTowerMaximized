var text = GetAsTime(o_GameManager.level.time);



draw_set_halign(fa_center);
draw_set_font(global.misc.font);
if(o_GameManager.level.time < 60) draw_set_color(c_red);
draw_text(480, 65, text);
GUI_RESET;