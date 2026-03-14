fitness = 0;
time = 0;
generation = 0;
goodGeneration1 = -1;
goodGeneration2 = -1;
succeeds = 0;
generations = [[]];
inputs = [];
distance = 10000;
o_Camera.hudVisible = false;
function AI_Input(_index, _value) constructor {
	index = _index;
	value = _value;
}
function Generation(pSuceeded, pEndScore, pInputs, pTotalTime) constructor {
	suceeded = pSuceeded;
	endScore = pEndScore;
	totalTime = pTotalTime;
	inputs = pInputs;
}

ToggleKey = function(key) {
	if(keyboard_check(key)) keyboard_key_release(key);
	else keyboard_key_press(key);
}
AddGeneration = function(pSuceeded) {
	if(pSuceeded) {
		Log("Success!");
		if(goodGeneration1 == -1) goodGeneration1 = generation;
		else goodGeneration2 = generation;
		succeeds++;
	}
	generations[generation] = new Generation(pSuceeded, fitness, inputs, time);
	array_push(generations, []);

}
game_set_speed(480, gamespeed_fps);
StartRun = function() {
	randomize();
	if(array_length(generations) > 5 && false) {
		for(var i = 0 ; i < array_length(generations);i++) {
			if(!generations[i].suceeded) {
				for(var j = i; j < array_length(generations) - 1;j++) {
					generations[j] = generations[j + 1];
				}
				array_resize(generations, array_length(generations) - 1);
				break;
			}
		}
	}
	/*
	var output = "";
	
	for(var i = 0 ; i < array_length(generations[generation]);i++) {
		var current = generations[generation][i];
		output += string(current.index) + " : " + string(current.value) + "\n";
	}
	show_message(output);
	*/
	time = 0;
	generation++;
	fitness = 0;
	inputs = [];
	o_Player.x = 96;
	o_Player.y = 512;
	distance = 10000;
	o_Player.setState("normal");
};

Fail = function() {
	AddGeneration(false);
	StartRun();
}

Goal = function() {
	AddGeneration(true);
	StartRun();
}

function Neuron(_name, activate) constructor {
	name = _name;
	exec = activate;
}
neurons = [
	new Neuron("Move right", function(){ToggleKey(vk_right)}),
	new Neuron("Jump", function(){ToggleKey(ord("Z"))}),
	new Neuron("Run", function(){ToggleKey(ord("X"))}),
	new Neuron("Do nothing", function(){}),
	new Neuron("Do nothing", function(){}),
	new Neuron("Do nothing", function(){}),
];

ActivateNeuron = function(index) {
	//Log(index);
	//show_message(index);
	neurons[index].exec();
	//Log(neurons[index].name);
	array_push(inputs, new AI_Input(index, fitness));
	
}

ImportGenerations = function() {
	var fileName = get_open_filename("Generation buffer|*.GENBUF", "");
	if(fileName == "") return;
	var buffer = buffer_load(fileName);
	var generationLength = buffer_read(buffer, buffer_u8);
	var inputsLength = -1;
	for(var i = 0 ; i < generationLength;i++) {
		if(i > 0) array_push(generations, new Generation(false, 0, [], 0));
		
		generations[i].suceeded = buffer_read(buffer, buffer_u8);
		generations[i].endScore = buffer_read(buffer, buffer_u8);
		generations[i].totalTime = buffer_read(buffer, buffer_u16);
		inputsLength = buffer_read(buffer, buffer_u8);
		for(var j = 0; j < inputsLength;j++) {
			array_push(generations[i].inputs, new AI_Input(buffer_read(buffer, buffer_u8), buffer_read(buffer, buffer_u8)));
		}
	}
}

ExportGenerations = function() {
	var fileName = get_save_filename("Generation buffer|*.GENBUF", "");
	if(fileName == "") return;
	var buffer = buffer_create(1, buffer_grow, 1);
	buffer_write(buffer, buffer_u8, array_length(generations));
	for(var i = 0 ; i < array_length(generations);i++) {
		buffer_write(buffer, buffer_u8, generations[i].suceeded);
		buffer_write(buffer, buffer_u8, generations[i].endScore);
		buffer_write(buffer, buffer_u16, generations[i].totalTime);
		buffer_write(buffer, buffer_u8, array_length(generations[i].inputs));
		for(var j = 0; j < array_length(generations[i].inputs);j++) {
			buffer_write(buffer, buffer_u8, generations[i].inputs[j].index);
			buffer_write(buffer, buffer_u8, generations[i].inputs[j].value);
		}
	}
	
}