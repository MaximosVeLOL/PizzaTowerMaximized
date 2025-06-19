if(!variable_struct_get(o_GameManager.level.pizzakin, type)) {
	if(type == "null" || playerID != -1) return;
	playerID = other.PD;
	variable_struct_set(o_GameManager.level.pizzakin, type, true);
	PlaySound(sfx_bigcollect);
	persistent = true;
}
