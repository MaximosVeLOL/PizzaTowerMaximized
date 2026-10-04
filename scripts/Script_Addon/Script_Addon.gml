#macro USE_CATSPEAK true

enum Addon_Type {
	//Only a script
	Script = 0b00000001,
	//Includes assets to replace or new ones
	Asset = 0b00000010,
	//Includes a level editor level, we can probably make this an asset
	Level = 0b00000100,
};


function Addon_Load(pName) {
	var folderDir = BASE_DIRECTORY + "/addons/" + pName;
	var buf = buffer_load(folder + "/info.json");
	
	var ERR_NONE = 0x00;
	var ERR_FILE = 0x01;
	var ERR_PARSE = 0x02;
	var ERR_NEEDED = 0x03;
	
	if(!buf)
		return ERR_FILE;
	var jsonString = buffer_read(buf, buffer_string);
	buffer_delete(buf);
	var info = json_parse(jsonString);
	
	var itemExists = function(pName) {
		return variable_struct_exists(info, pName);
	}
	
	//Check for the core info
	var checks = ["name", "type"];
	for(var i = 0 ; i < 2;i++) if(!itemExists(checks[i])) return ERR_PARSE;
	
	//Check for dependencies
	if(itemExists("needed")) {
		for(var i = 0 ; i < array_length(info.needed);i++) {
			var ret = Addon_Load(info.needed[i]);
		}
	}
	
	
	return ERR_NONE;
}

function Addon_CreateRunner() {
	return {
		loaddedAddons : [],
	};
}

function Addon_PTM_CreateObject(pName, ) {
	
}