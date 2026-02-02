event_inherited();
sprite_index = o_Player.sprite_index;
image_xscale = o_Player.xscale;
mass = 0;
canMove = true;
if(o_Player.state == "mach3" || o_Player.state == "mach2") velocity.y = instance_number(object_index) == 1 ? 5 : -5;
else velocity.x = instance_number(object_index) == 1 ? 5 : -5;
if(instance_number(object_index) < 2 && global.settings.gameplaySettings.fpsSave != FPSSaveMode.OnlyTheNeccessary && global.settings.gameplaySettings.fpsSave != FPSSaveMode.VisualRemover) instance_create_depth(x,y,0,object_index);