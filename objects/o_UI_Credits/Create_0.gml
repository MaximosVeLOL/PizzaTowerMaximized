draw_set_font(ComicSans);
text = @"Credits:


Maximos Ve

Game Designer
Main Programmer
Play Tester
Concept Creator
Sprite Artist


Jun (pin)

Created Pizza Tower: Pre-Alpha Experience
Concept Inspiration
Sprite Artist


Tour De Pizza

Created Pizza Tower
Programming Inspiration
Sprite Artist
Concept Inspiration
Asset Holder
Copyright Holder
Sound Designer


pixabay.com

Sound Designer


Garlicker

Bug Reporter
Play Tester (kind of)
Awesome Person
Awesome Person
Awesome Person
Awesome Person
Awesome Person
Awesome Person
Thank you Garlicker
Thank you Garlicker
Thank you Garlicker
Thank you Garlicker
Thank you Garlicker
Thank you Garlicker


USER

Playing the Game
Play Tester (kind of)



Thank you Garlicker (again)
"
var name = environment_get_variable("USERNAME");
if(name == "") name = "You!"
var pos = string_pos("USER", text);
text = string_copy(text, 0, pos - 1) + name + string_copy(text, pos + 5, string_length(text) - pos);
pressed = false;
//y += 540 + string_height(text);
y = 540;
depth = -999;
if(instance_exists(o_MusicManager)) o_MusicManager.playNewSong(music_credits);