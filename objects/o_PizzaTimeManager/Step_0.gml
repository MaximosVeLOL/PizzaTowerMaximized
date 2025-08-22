if(!paused) o_GameManager.level.time -= TIME_BASE;
if(o_GameManager.level.time <= 0) {
	paused = true;
	Log("Time Up!");
	o_GameManager.endLevel();
}