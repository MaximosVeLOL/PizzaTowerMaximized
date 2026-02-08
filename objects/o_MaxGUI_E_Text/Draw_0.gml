if(!o_GUIHandler.active) return;
draw_set_halign(horAlign);
draw_set_valign(verAlign);
draw_set_color(color);
draw_text(x,y,text);
GUI_RESET;
