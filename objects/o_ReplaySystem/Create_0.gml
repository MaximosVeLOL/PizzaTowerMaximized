function Input(pKey, pTime = 0) constructor {
	key = pKey;
	time = pTime;
}
startingCondition = {
	position : new Vector(),
	room : noone,
};
inputs = [];
inputIndex = 0;
waitTime = 0;
mode = 0;