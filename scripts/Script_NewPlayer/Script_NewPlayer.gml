
//28 total members
//64-bit pointer size = 8
//28 * 8 = 224 bytes
//224 bytes of memory taken up versus constant CPU stress
//Performance UP!
//#macro PLAYER_IS_MACH(state) (state == PlayerState.Mach1 || state == PlayerState.Mach2 || state == PlayerState.Mach3 || state == PlayerState.MachFreefall)
function PlayerIsMachState(state, moveSpeed = -1) {
	return(state == PlayerState.Mach1 || state == PlayerState.Mach2 || state == PlayerState.Mach3 || state == PlayerState.MachFreefall || state == PlayerState.MachRoll || (moveSpeed == -1 ? state == PlayerState.MachSlide : state == PlayerState.MachSlide && moveSpeed >= 10))
}
#macro USE_ENUM true
#macro USE_ARRAY true



function PlayerStateFunctions(moveSet, state) {
	switch(moveSet) {
		case Moveset.ETB: //ETB code lies here
			switch(state) {
				//DEF-normal
				case PlayerState.Normal:
                    return Player_State_ETB_Normal;
				
	
				case PlayerState.Mach1:
					return Player_State_ETB_Mach1;
				
	
				case PlayerState.Mach2:
					return Player_State_ETB_Mach2;
					
			
                case PlayerState.Mach3:
                    return Player_State_ETB_Mach3;
                
        
                case PlayerState.MachSlide:
                    return Player_State_ETB_MachSlide;
                
        
                case PlayerState.CrouchSlide:
                    return Player_State_ETB_CrouchSlide;
                    
                
        
                case PlayerState.MachRoll:
                    return Player_State_ETB_MachRoll;
                
        
        
                case PlayerState.MachFreefall:
                    return Player_State_ETB_MachFreefall;
                
	
				case PlayerState.Jump:
					return Player_State_ETB_Jump;
				
	
				case PlayerState.Bump:
					return Player_State_ETB_Bump;
		
		
				
	
				case PlayerState.Noclip:
					return Player_State_ETB_Noclip;
				
	
	
				case PlayerState.SuperJump:
					return Player_State_ETB_SuperJump;
				
	
				case PlayerState.HighJump:
					return Player_State_ETB_HighJump;
				
	
				case PlayerState.Crouch:
                    return Player_State_ETB_Crouch;
				
	
				case PlayerState.Freefall:
                    return Player_State_ETB_Freefall;
				
	
				case PlayerState.SuperSlam:
					return Player_State_ETB_SuperSlam;
				
	
				case PlayerState.Ladder:
					return Player_State_ETB_Ladder;
				
	
				//Transition Stuff here
				case PlayerState.Transition:
					return Player_State_ETB_Transition;
				
	
				case PlayerState.Door:
					return Player_State_ETB_Door;
				
	
				case PlayerState.Enemy:
                    return Player_State_ETB_Enemy;
				
	
				case PlayerState.Key:
					return Player_State_ETB_Key;
	
				//TRANSFORMATION
				case PlayerState.Knight:
					return Player_State_ETB_Knight;
				
	
				case PlayerState.Hurt:
					return Player_State_ETB_Hurt;
				
				
				//TRANSFORMATION
				case PlayerState.Bomb:
					return Player_State_ETB_Bomb;
				
	
				case PlayerState.Treasure:
					return Player_State_ETB_Treasure;
				
	
				case PlayerState.Slip:
                    return Player_State_ETB_Slip;
				
	
				default:
                    return Player_State_Any_DefaultCase;
				
				
				
				case PlayerState.Barrel:
                    return Player_State_ETB_Barrel;
				
				
				case PlayerState.Hump: //Such a simple state.
                    return Player_State_ETB_Hump;
				
			}
        break;
		 //End of ETB
    }
		/*
		//Boxing gamemode!
		case Moveset.Boxer:
			switch(state) {
				case PlayerState.Normal:
					//Normal state here
				
				
				case "jump":
					//Normal jump here
					if(GetInput("jump", 1, playerID) && velocity.y > 0) {
						setState(PlayerState.SuperSlam);
					}
				
				
			}
		
		*/
	//Moveset case

}

function PlayerStateToString(pIndex) {
    if(true || pIndex > PlayerState.Mach3) return string(pIndex);
    //return [PlayerState.Normal, "mach1", "mach2", "mach3"][pIndex];
}