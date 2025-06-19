draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_black);
draw_rectangle(-1,-1, 961,541,false);
draw_set_color(c_white);
draw_set_font(-1);
draw_text(480, y, text );
y--;
GUI_RESET;