draw_self();
if(!renderText) return;
draw_set_font(global.misc.font);
draw_set_halign(fa_center);
draw_text(x,bbox_top, levelName);
GUI_RESET;