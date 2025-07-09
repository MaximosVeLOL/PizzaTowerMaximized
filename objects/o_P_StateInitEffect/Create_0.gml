event_inherited();
sprite_index = o_PlayerParent.sprite_index;
image_xscale = o_PlayerParent.xscale;
mass = 0;
canMove = true;
if(o_PlayerParent.state == "mach3" || o_PlayerParent.state == "mach2") velocity[1] = instance_number(object_index) == 1 ? 5 : -5;
else velocity[0] = instance_number(object_index) == 1 ? 5 : -5;
if(instance_number(object_index) < 2 && global.settings.gameplaySettings.fpsSave != FPSSaveMode.OnlyTheNeccessary && global.settings.gameplaySettings.fpsSave != FPSSaveMode.VisualRemover) instance_create_depth(x,y,0,object_index);