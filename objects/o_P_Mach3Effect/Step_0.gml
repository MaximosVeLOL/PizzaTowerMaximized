frames++;
if(frames == 3) image_alpha = 0;
if(frames == 6) image_alpha = 0.8;
if(frames == 15) instance_destroy();
//if(obj_player.state != "mach3" && obj_player.state != "superJump" && obj_player.state != "machroll") instance_destroy();