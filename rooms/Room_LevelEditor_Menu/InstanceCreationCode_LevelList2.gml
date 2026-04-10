//Thanks GML Docs!
Log(BASE_DIRECTORY);
var name = file_find_first(BASE_DIRECTORY + "/LevelEditor/*.PTMLVL", fa_none);
while (name != "")
{
	//show_message(name);
	name = string_copy(name, 0, string_pos(".", name) - 1);
    array_push(list, name);
    name = file_find_next();
}
file_find_close();

onSwitch = function(newIndex) {
	var playMode = instance_exists(o_C_Parent);
	o_MaxGUI_Handler.Destroy();
	var e = instance_create(x, y, o_LevelEditor, {playOnEnter : playMode});
	room_goto(Room_LevelEditor);
	e.ImportLevel(BASE_DIRECTORY + "/LevelEditor/" + name + ".PTMLVL");
	e.level.name = self.list[newIndex];
	if(playMode) {
		e.playOnEnter = true;
	}
}