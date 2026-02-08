event_inherited();
objectList = [
	["Collision", o_C_Wall, o_C_Slope, o_C_Platform],
	["Warp", o_Le_Transition, o_Le_Door, o_Le_KeyDoor, o_Le_LevelGate],
	["Collectables", o_Le_Points, o_Le_Pizzakin, o_Le_BigPoints, o_Le_Treasure, o_Le_Key, o_Le_LapPoints, o_Le_Pizzabox],
	["Level", o_Le_Ladder, o_Le_Barrel, o_Le_SpeedBoost, o_Le_Spike, o_Le_Sword, o_Le_Lap, o_Le_RedGuy, o_Le_Water],
	["Enemies", o_Le_En_Cheeseslime, o_Le_En_Forknight, o_Le_En_SausageMan, o_Le_En_PepGoblin],
	["Special", o_Player, o_Camera],
	["Breakables", o_B_Block, o_B_BlockPoints, o_B_Door, o_B_Metal, o_B_OneWayWall],
];
objectPage = 0;
objectSelected = [-1, -1];
doHighlight = false;
depth = -5;