var currentDistance = abs(o_AI_Goal.x - o_Player.x);
//Log(string(currentDistance));
//Log(string(distance));
if(currentDistance < distance) {
	fitness++;
	distance = currentDistance;
}
else {
	fitness--;
	if(fitness < -100) {
		Fail();
	}
}
if(array_length(inputs) > 0) //If we have made an input
	inputs[array_length(inputs) - 1].value = fitness;

if(keyboard_check_pressed(ord("O"))) ExportGenerations();
if(keyboard_check_pressed(ord("I"))) ImportGenerations();

var targetIndex = round(random_range(0, array_length(neurons) - 1));
if(goodGeneration1 != -1 && goodGeneration2 != -1) { //More than 2 generations
	var firstGen = generations[goodGeneration1].inputs;
	var secondGen = generations[goodGeneration2].inputs;
	var index = array_length(inputs); //Our current input
	if(array_length(firstGen) > index && array_length(secondGen) > index) {
		targetIndex = (firstGen[index].value > secondGen[index].value ? firstGen[index].index : secondGen[index].index);
		//if(firstGen[index].value > secondGen[index].value) Log("Using first gen!");
		//else Log("Using second gen!");

	}
}
time++;
ActivateNeuron(targetIndex);