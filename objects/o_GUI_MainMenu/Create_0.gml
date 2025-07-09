event_inherited();

add(new Screen());
screens[0].Add(new Button(380, 20, 200, 100, function(){show_message_async("Placeholder!")}, "Look for levels"));
screens[0].Add(new Button(380, 140, 200, 100, function(){instance_create_depth(0,0,0,o_GUI_LevelEditor);o_GUI_LevelEditor.createLevel();}, "Make a level"));
screens[0].Add(new Button(380, 260, 200, 100, function(){}, "Load a level"));