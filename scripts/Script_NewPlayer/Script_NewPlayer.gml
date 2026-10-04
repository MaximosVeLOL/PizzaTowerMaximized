
//28 total members
//64-bit pointer size = 8
//28 * 8 = 224 bytes
//224 bytes of memory taken up versus constant CPU stress
//Performance UP!
//#macro PLAYER_IS_MACH(state) (state == PlayerState.Mach1 || state == PlayerState.Mach2 || state == PlayerState.Mach3 || state == PlayerState.MachFreefall)
function PlayerIsMachState(state, moveSpeed = -1) {
	return(state == PlayerState.Mach1 || state == PlayerState.Mach2 || state == PlayerState.Mach3 || state == PlayerState.MachFreefall || state == PlayerState.MachRoll || (moveSpeed == -1 ? state == PlayerState.MachSlide : state == PlayerState.MachSlide && moveSpeed >= 10))
}
function PlayerIsState(pState) {
	
}
function PlayerStateToString(pState) {
	return string(pState);
}
#macro USE_ENUM true
#macro USE_ARRAY true

//#macro PLAYER_MOVESET_TRANSFORMATION_END 