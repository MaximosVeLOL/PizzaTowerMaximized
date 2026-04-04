if(global.settings.gameplaySettings.fpsSave = FPSSaveMode.UselessRemover || array_length(logs) == 0) return;

var buf = buffer_create(0, buffer_grow, 1);
for(var i = 0 ; i < array_length(o_DEBUG_Console.logs);i++) { //gamemaker gives us an error when using the with()
	buffer_write(buf, buffer_string,  o_DEBUG_Console.logs[i]);
}
//If you want to have it compressed, but that doesn't make sense...
//buf = buffer_compress(buf, 0, buffer_get_size(buf))
buffer_save(buf, BASE_DIRECTORY + "/LatestLog.txt");