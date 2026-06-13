event_inherited();
//Struct names aren't in order when using variable_struct_get_names()?
//Hack for GameMaker's issue
names = ["up", "down", "left", "right", "jump", "dash"/*, "Shoot"*/];
var o = new Vector(480, 270);
var bg = new Screen_Background(noone, c_black, 0, 0, c_white, c_gray, global.misc.font, fa_center, fa_middle);
screens = [
    new Screen("m", 
        array_create_ext(array_length(names) + 1, function(i)
            {
                if(i == array_length(names)) {
                    return new Option("Back", OptionType.Button, function(){instance_destroy();instance_activate_object(o_UI_Settings);}) 
                }
            return new Option(names[i], 6, undefined)
            }),
     "Select a key", bg, 1, undefined, new Vector(), o),
    new Screen("k", [new Option("Press any key!", OptionType.Button, function(){})], "Press any key!", bg, 3, undefined, new Vector(), o),
];
setAllToUpper();
profile = 0;
targetKey = 0;
onPressed = function() {
    interactingWithOption = false;
    targetKey = currentOption;
    setScreen(1);
    return true;
}