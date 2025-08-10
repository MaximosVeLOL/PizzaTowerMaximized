if(variable_struct_get(o_GameManager.level.pizzakin, type)) {
        image_alpha = o_PlayerParent.image_alpha; //This is used when going into the door transition... What a waste of cycles...
        if(o_PlayerParent.movespeed != 0) {
            setSprite("run");
        }
        else setSprite("idle");
            /*
        if (place_meeting(x, y, obj_water2) || place_meeting(x, y, obj_water))
        {
            sprite_index = spr_pizzakinshroom_underwater
        }
        */
        
        ds_queue_enqueue(followQueue, o_PlayerParent.x);
        ds_queue_enqueue(followQueue, o_PlayerParent.y);
        
        if (ds_queue_size(followQueue) > (LAG_STEPS * 2))
        {
            x = ds_queue_dequeue(followQueue) - ((image_xscale) * 4)
            y = ds_queue_dequeue(followQueue) + 2
        }
        
        image_xscale = o_PlayerParent.xscale;
    if (o_PlayerParent.state == "hurt" || o_PlayerParent.state == "current")
    {
		setSprite("panic");
    }
	
}
else setSprite("idle");