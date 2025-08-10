if(!variable_struct_get(o_GameManager.level.pizzakin, type)) {
	variable_struct_set(o_GameManager.level.pizzakin, type, true);
	PlaySound(sfx_bigcollect);
	persistent = true;
}
