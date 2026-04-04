onClick = function() {
	try {
		if(instance_create_depth(0, 0, 0, Net_o_Server).setupServer(real(MaxGUI_FindElement("hM").text))) {
			o_GameManager.goToHub();
			o_GameManager.mode = "game";
			return true;
		}
		return false;
	}
	catch(e) {instance_destroy(Net_o_Server);return false;}
}