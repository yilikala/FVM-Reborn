var _enemies = []
with(obj_enemy_parent){
	if can_target_on("split", target_type) && hp > 0 {
		array_push(_enemies, id)
	}
}
var _ec = array_length(_enemies)
fire_queue = []
if _ec == 0 { exit }

array_sort(_enemies, function(_a, _b){ return _a.x - _b.x })

var _groups = 6
var _alloc = array_create(_ec, 0)

if _ec >= _groups {
	for (var i = 0; i < _groups; i++) { _alloc[i] = 1 }
} else {
	var _base = _groups div _ec
	var _rem = _groups mod _ec
	for (var i = 0; i < _ec; i++) {
		_alloc[i] = _base + (i < _rem ? 1 : 0)
	}
}

for (var i = 0; i < _ec; i++) {
	for (var j = 0; j < _alloc[i]; j++) {
		array_push(fire_queue, _enemies[i])
	}
}
