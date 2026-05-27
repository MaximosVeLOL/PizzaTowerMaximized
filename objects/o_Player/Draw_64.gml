draw_text(20, 20, "FPS: " + string(fps_real));
draw_text(20, 40, "Highest: " + string(TEMPHighest));
draw_text(20, 60, "State Index: " + string(state));
draw_text(20, 80, "State name: " + global.TEMP_StateNames[state]);
if(fps_real > TEMPHighest)
	TEMPHighest = fps_real;