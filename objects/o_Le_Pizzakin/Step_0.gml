if(variable_struct_get(o_GameManager.level.pizzakin, type)) {
        image_alpha = instance_find(o_PlayerParent, playerID - 1).image_alpha;
        if(instance_find(o_PlayerParent, playerID - 1).movespeed != 0) {
            setSprite("run");
        }
        else setSprite("idle");
            /*
        if (place_meeting(x, y, obj_water2) || place_meeting(x, y, obj_water))
        {
            sprite_index = spr_pizzakinshroom_underwater
        }
        */
        
        ds_queue_enqueue(followQueue, instance_find(o_PlayerParent, playerID - 1).x);
        ds_queue_enqueue(followQueue, instance_find(o_PlayerParent, playerID - 1).y);
        
        if (ds_queue_size(followQueue) > (LAG_STEPS * 2))
        {
            x = ds_queue_dequeue(followQueue) - ((image_xscale) * 4)
            y = ds_queue_dequeue(followQueue) + 2
        }
        
        image_xscale = instance_find(o_PlayerParent, playerID - 1).xscale;
    if (instance_find(o_PlayerParent, playerID - 1).state == "hurt" || instance_find(o_PlayerParent, playerID - 1).state == "current")
    {
        sprite_index = spr_pizzakin_shroom_panic
    }
	
}
else setSprite("idle");