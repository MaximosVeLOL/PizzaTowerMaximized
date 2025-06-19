var buf = buffer_create(0, buffer_grow, 1);
for(var i = 0 ; i < array_length(o_DEBUG_Console.logs);i++) { //gamemaker gives us an error when using the with()
	buffer_write(buf, buffer_string,  o_DEBUG_Console.logs[i]);
}
buffer_save(buffer_compress(buf, 0, buffer_tell(buf)), "MaximizedGM2/LatestLog.txt");