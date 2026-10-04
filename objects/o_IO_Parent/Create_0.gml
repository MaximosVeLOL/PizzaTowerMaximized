GetTarget = function() {
	with(o_IO_Parent) {
		if(name == other.target)
			return id;
	}
	Log("(IO) Failed to find target " + target + "!");
	return noone;
}
//For scripting usage?
GetVariable = function(pName) {
	return variable_instance_get(id, pName);
}