if(!variable_struct_get(o_GameManager.level.pizzakin, type)) return;
image_alpha = o_Player.image_alpha; //This is used when going into the door transition.settings.. What a waste of cycles.settings..
if(o_Player.movespeed != 0) {
	setSprite("run");
}
else setSprite("idle");
if(place_meeting(x, y, o_Le_Water))
	setSprite("water");
/*
if (place_meeting(x, y, obj_water2) || place_meeting(x, y, obj_water))
{
    sprite_index = spr_pizzakinshroom_underwater
}
*/

array_push(follow, new Vector(masterObject.x, (object_get_parent(masterObject.object_index) == o_Player ? o_Player.y : masterObject.y - 2)) );	
delay++;
if (delay >= 20) {
	var vec = follow[delay];
    //x = ds_queue_dequeue(followQueue) - ((image_xscale) * 4)
    //y = ds_queue_dequeue(followQueue) + 2
	x = vec.x - (image_xscale * 4);
	y = vec.y + 2;
	array_pop(follow);
	delay--;
}
        
image_xscale = o_Player.xscale;
if (o_Player.state == "hurt" || o_Player.state == "current") {
	setSprite("panic");
}
