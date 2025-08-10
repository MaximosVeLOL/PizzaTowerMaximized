event_inherited();
allObjects[0] = CreateButton(new GUI_Rect(380, 20, 200, 100), "FindButton", "Find a Level", function(){});
allObjects[1] = CreateButton(new GUI_Rect(380, 220, 200, 100), "CreateButton", "Create a Level", function(){instance_create_depth(0,0,0,o_MUI_LevelEditor).createLevel();});
allObjects[2] = CreateButton(new GUI_Rect(380, 420, 200, 100), "CreateButton", "Create a Level (OG GUI)", function(){instance_create_depth(0,0,0,o_GUI_LevelEditor).createLevel();});