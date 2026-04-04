if(!o_MaxGUI_Handler.active) return;
draw_set_halign(horAlign);
draw_set_valign(verAlign);
draw_set_font(font);
draw_set_color(color);
draw_text(x,y,text);
GUI_RESET;
