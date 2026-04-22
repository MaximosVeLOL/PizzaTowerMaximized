if(!hooked) return;

plr.x = x + (sprite_width / 2);
plr.y = y + 40;
if(GetInput("jump", 1) || place_meeting(x, y, o_Le_HookEnd)) {
	destroy();
}