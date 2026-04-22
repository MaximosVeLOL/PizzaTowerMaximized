//Every single time I run instance_activate_all(), it doesn't allow for the Game manager to destroy all instances.settings..
//So heres my hack!
if(instance_exists(Net_o_Client))
	Net_o_Client.startDisconnect();
else if(instance_exists(Net_o_Server))
	Net_o_Server.destroy();
else
	o_GameManager.returnToMenu();