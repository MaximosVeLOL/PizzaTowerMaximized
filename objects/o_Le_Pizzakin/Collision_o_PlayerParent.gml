if(variable_struct_get(o_GameManager.level.pizzakin, type)) return;

variable_struct_set(o_GameManager.level.pizzakin, type, true);
PlaySound(sfx_bigcollect);
persistent = true;

//Find the pizzakin to follow
var names = ["shroom", "cheese", "tomato", "sausage", "pineapple"];
for(var i = 0 ; i < array_length(names) ; i++) {
	if(names[i] == type) continue;
		
	if(struct_get(o_GameManager.level.pizzakin, names[i])) { 
		for(var j = 0 ; j < instance_number(o_Le_Pizzakin);j++) {
			if(instance_find(o_Le_Pizzakin, j).type == names[i]) {
				masterObject = instance_find(o_Le_Pizzakin, j);
				break;
			}
		}
	}
}
//LogError(object_get_name(masterObject.object_index));

