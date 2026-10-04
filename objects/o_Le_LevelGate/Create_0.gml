
renderText = false;
textToRender = Level_GetInfo(targetLevel).levelName; //Variable is defined before creation code, so we can do this now.
gotData = false;
//The condition of all the pizzakins, could be optimized, but I don't wanna do GML bitwise operations
pizzakins = [false, false, false, false, false];
//Try to find a reference to the sprites, or make our own
//pizzakinSprite = (instance_number(o_Le_LevelGate) > 1 ? instance_find(o_Le_LevelGate, 0).pizzakinSprite : [spr_pizzakin_shroom_idle, spr_pizzakin_cheese_idle, spr_pizzakin_tomato_idle, spr_pizzakin_sausage_idle, spr_pizzakin_pineapple_idle]);
pizzakinSprite = [spr_pizzakin_shroom_idle, spr_pizzakin_cheese_idle, spr_pizzakin_tomato_idle, spr_pizzakin_sausage_idle, spr_pizzakin_pineapple_idle];

if(gotoLevel && targetLevel != LevelIndex.None && global.settings.saveFileIndex != -1) {
	var b = buffer_load(BASE_DIRECTORY +  "/Save" + string(global.settings.saveFileIndex) + "/lvl" + string(targetLevel) + ".info");
	if(b != -1) {
		textToRender += "\n" + ["F", "D", "C", "B", "A"][buffer_read(b, buffer_u8)];
		//This is useless though, but I'm keeping it for now.
		if(buffer_read(b, buffer_u8) != targetLevel) {
			LogError("Our level that we are reading is not equal to file's level index!");
			return;
		}
		textToRender += "\n" + string(buffer_read(b, buffer_u32));
		for(var i = 0 ; i < 5;i++) {
			pizzakins[i] = buffer_read(b, buffer_u8);
		}
		gotData = true; 
        buffer_delete(b);
    }
    
}
depth = 150;