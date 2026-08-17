var _has_attire = (card_equipped_attire_id(plant_id) != -1)
var _flame_count = 2
if shape >= 1{
	_flame_count = 3
}
if _has_attire{
	if shape == 0{
		_flame_count = 4
	}
	else if shape == 2{
		_flame_count = 6
	}
}

for (var _i = 0; _i < _flame_count; _i++){
	var inst = instance_create_depth(x, y - 60, depth - 1000, obj_flame);
	inst.value = flame_produce
}