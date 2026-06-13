if(!variable_struct_get(o_GameManager.level.pizzakin, type)) return;
image_alpha = o_Player.image_alpha; //This is used when going into the door transition.settings.. What a waste of cycles.settings..
if(o_Player.movespeed != 0) {
	setSprite("run");
}
else setSprite("idle");
if(place_meeting(x, y, o_Le_Water))
	setSprite("water");
//ticks++;

//if(ticks < 4) return;
//ticks = 0;
/*
ds_queue_enqueue(followQueue, masterObject.x);
var realValue = (object_get_parent(masterObject.object_index) == o_Player ? o_Player.y : masterObject.y - 2);
ds_queue_enqueue(followQueue, realValue);
        
if (ds_queue_size(followQueue) > 20)
{
    x = ds_queue_dequeue(followQueue) - ((image_xscale) * 4)
    y = ds_queue_dequeue(followQueue) + 2
}
*/


//Start adding position to queue
//Check if we have more than 20 elements (0 - 20) 
//If we do
//Set position to items first in queue
//Also remove then from queue

//0

//this[0] = 0
//0++

//this[1] = unset data
//1

// 1 - 0 = 0 (valid)
// 0 - 0 = 1
//if(delay > 1 && follow[delay] == follow[delay - 1])
//	delay--;
if(delay >= 1) {
	
	follow[delay].x = masterObject.x;
	follow[delay].y = (masterObject.object_index == o_Player ? o_Player.y : masterObject.y - 2);
	if(follow[delay].x == follow[delay - 1].x) {
		follow[delay] = new Vector();
		delay--;
	}
} 
if(delay + 1 == FOLLOW_MAX) {
	var vec = follow[FOLLOW_MAX - delay - 1];
	x = vec.x - (image_xscale * 4);
	y = vec.y + 2;
	delay--;
}

/*
var l = array_last(follow);




if(l != undefined && (l.x != follow[delay].x || l.y != follow[delay].y )) delay--;
if(delay >= FOLLOW_MAX - 1) {
	
    //x = ds_queue_dequeue(followQueue) - ((image_xscale) * 4)
    //y = ds_queue_dequeue(followQueue) + 2

	//array_pop(follow);
	delay--;
}
else delay++;
*/      
image_xscale = o_Player.xscale;
if (o_Player.state == PlayerState.Hurt || o_Player.state == PlayerState.Slip) {
	setSprite("panic");
}
