//image_speed = 0.5; //Draw sprite just uses 60 fps no matter what.
image_speed = 0;
//ranks = ["F", "D", "C", "B", "A", "S"];
rankSprites = [sprite_hud_rank_f, sprite_hud_rank_d, sprite_hud_rank_c, sprite_hud_rank_b, sprite_hud_rank_a, sprite_hud_rank_s];
sprite_index = sprite_hud_rank_trans;
rankMusic = PlaySound(music_rank);
fadeAlpha = 0;
alarm[0] = 400; // 400 / 60 = 