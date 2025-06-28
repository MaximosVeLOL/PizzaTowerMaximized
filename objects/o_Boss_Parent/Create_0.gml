settings = {
	hp : 0,
	maxHP : 8,
	hpBarWidth : 4,
};
enum BossState {
	Intro = -1,
	Idle,
	Attacking,
	CustomMove0,
	CustomMove1,
	CustomMove2,
	CustomMove3,
	CustomMove4,
};
states = [];
for(var i = 0 ; i < BossState.CustomMove4;i++) {
	array_push(states, random_range(BossState.Attacking, BossState.CustomMove4));
}