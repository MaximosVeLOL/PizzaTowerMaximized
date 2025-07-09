event_inherited();
canMove = true;
velocity[1] = -abs(o_PlayerParent.velocity[0]);
velocity[0] = 5 * o_PlayerParent.xscale;
image_xscale = o_PlayerParent.xscale;