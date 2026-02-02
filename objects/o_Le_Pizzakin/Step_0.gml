if(!variable_struct_get(o_GameManager.level.pizzakin, type)) return;
image_alpha = o_Player.image_alpha; //This is used when going into the door transition... What a waste of cycles...
if(o_Player.movespeed != 0) {
	setSprite("run");
}
else setSprite("idle");
/*
if (place_meeting(x, y, obj_water2) || place_meeting(x, y, obj_water))
{
    sprite_index = spr_pizzakinshroom_underwater
}
*/
        
ds_queue_enqueue(followQueue, masterObject.x);
var realValue = (object_get_parent(masterObject.object_index) == o_Player ? o_Player.y : masterObject.y - 2);
ds_queue_enqueue(followQueue, realValue);
        
if (ds_queue_size(followQueue) > 20)
{
    x = ds_queue_dequeue(followQueue) - ((image_xscale) * 4)
    y = ds_queue_dequeue(followQueue) + 2
}
        
image_xscale = o_Player.xscale;
if (o_Player.state == "hurt" || o_Player.state == "current")
{
	setSprite("panic");
}
