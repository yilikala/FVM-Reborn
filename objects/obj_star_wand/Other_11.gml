// 星之神杖：构建发射队列（子弹由 Step 逐颗生成）
// 机制：n = 子弹数量
//   - 若场上敌人 >= n：选取最左侧的 n 个敌人，每人攻击一次
//   - 否则：将额外子弹平均分配给场上敌人，部分敌人被攻击多次
var _enemies = []
with(obj_enemy_parent){
	if (can_hit("all",target_type) && hp > 0){
		array_push(_enemies, id)
	}
}
var _ec = array_length(_enemies)
fire_queue = []
burst_idx = 0
if _ec == 0{ exit }

// 按 x 升序排序（最左侧敌人优先）
array_sort(_enemies, function(_a, _b){ return _a.x - _b.x })

var n = bullet_count
var _alloc = array_create(_ec, 0)  // 每个敌人分配的子弹数
if _ec >= n{
	// 选取最左侧的 n 个敌人，每人 1 发
	for(var i = 0; i < n; i++){
		_alloc[i] = 1
	}
}
else{
	// 平均分配：每人 base 发，余数分给最左侧敌人
	var _base = n div _ec
	var _rem = n mod _ec
	for(var i = 0; i < _ec; i++){
		_alloc[i] = _base + (i < _rem ? 1 : 0)
	}
}

// 展开成发射队列（每个条目 = 一个目标敌人）
for(var i = 0; i < _ec; i++){
	for(var j = 0; j < _alloc[i]; j++){
		array_push(fire_queue, _enemies[i])
	}
}
