Input = function(reason) {

}

Output = function(target, reason) {
	target.Input(reason);
}

GetTarget = function() {
	with(o_IO_Parent) {
		if(name == other.target)
			return id;
	}
	Log("(IO) Failed to find target " + target + "!");
	return noone;
}