


if(sprite_index == sprite_level_treasure_get || global.settings.player.moveSet == Moveset.PreETB) return;
o_Player.setState("treasure");
sprite_index = sprite_level_treasure_get;
x = other.x;
y = other.y - 35;
if(global.settings.multiplayer.enabled) {
	o_Player.x = other.x;
	o_Player.y = other.y;
}
PlaySound(sfx_treasureget);
PlaySound(choose(va_happy1, va_happy2, va_happy3));
if(instance_exists(o_MusicManager)) o_MusicManager.stopMusic(true);