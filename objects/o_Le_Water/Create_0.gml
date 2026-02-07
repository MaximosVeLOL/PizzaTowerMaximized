isTop = place_meeting(x, y + 48, o_Le_Water); //If there is water below us, we are on top.
sprite_index = (isTop ? sprite_level_waterTop : sprite_level_waterBtm);
child = noone;