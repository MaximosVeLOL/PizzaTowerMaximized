#macro IS_DEBUGGING (os_get_config() == "Debug")
	
function Log(_message) { // 0 1 2 3 (size = 4)
	if(!IS_DEBUGGING) return;
	
	
	
	var log = "(" + string(get_timer() / 1_000_000) ;
	if(false) log += ", " + StrCat(room, _GMFILE_, _GMFUNCTION_, _GMLINE_ );
	log += ") : " + _message;
	//if(array_length(o_DEBUG_Console.logs) > 1 && log == o_DEBUG_Console.logs[array_length(o_DEBUG_Console.logs) - 1]) return; //This would always fail, because we add extra information to it.

	show_debug_message(log);
	with(o_DEBUG_Console) {
		array_resize(logs, array_length(logs) + 1);
		logs[array_length(logs) - 1] = log;
	}
}
function LogError(_message, crash = false) {
	//if(!global.settings.gameplay.debugEnabled) return;
	Log("LogError Message: " + _message);
	show_message("From object id " + string(id) + " (" + object_get_name(object_index) + ")\n" + _message);
	if(crash) throw("LogError Automatic Crash!");
}
function MarkDebugCode(pMessage) {
	if(IS_DEBUGGING) return;
	show_message("(MarkDebugCode) " + pMessage);
}
function Assert(pCondition, pFile = "", pFunction = "", pLine = "") {
	if(pCondition) {
		//var b = show_question("Assertion Failed! (" + pFile + ", " + pFunction + ", " + pLine + "\nShould we ignore? (y/n)");
		var b = show_question("Assertion Failed!\nShould we ignore? (y/n)");
		if(!b) game_end(1);
	}
}