onClick = function() {
	try {
		var ip = MaxGUI_FindElement("jI");
		instance_create_depth(0, 0, 0, Net_o_Client).tryConnect(ip.text);
	}
	catch(e) {instance_destroy(Net_o_Client);return false;}
}