draw_set_font(o_GameManager.font);
var s = o_GameManager.getScreenSize();
draw_set_color(c_black);
draw_rectangle(-1,-1, s[0], s[1], false);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_text(s[0] / 2, s[1] / 2, "YOU GOT A " + curRank + " RANK! (PLACEHOLDER)");