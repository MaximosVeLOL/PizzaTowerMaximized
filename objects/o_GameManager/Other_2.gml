/*if(global.settings.gameplaySettings.fpsSave == FPSSaveMode.OnlyTheNeccessary) {
	instance_destroy();
	return;
}*/
if(!file_exists("MaximizedGM2/SESSION")) {
	sessions.total++; //Still increase so we can create an accurate file next time
	return;
}
var bufferFile = buffer_load("MaximizedGM2/SESSION");
/*
for(var i = 0 ; i < 8;i++) {
	buffer_seek(bufferFile, buffer_seek_start, i);
	buffer_tell()
	if(i % 4 == 0 && i > 0) {
		buffer_read(bufferFile)
	}
}*/
sessions.total = buffer_read(bufferFile, buffer_s32) + 1;
sessions.save = buffer_read(bufferFile, buffer_s32);
buffer_delete(bufferFile); //Remember kids, always keep memory usage low!!!!!