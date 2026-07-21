image_xscale = 1.8
image_yscale = 1.8

instance_create_depth(1668, 80, depth-1, obj_exchange_menu_closer)


var _lx = x - 340
var _rx = x + 405
var _by = y - 32 
for (var _row = 0; _row < 4; _row++){
	var _row_y = y - 675 + _row * 170
	var _lb = instance_create_depth(_lx + 255, _row_y + _by, depth-1, obj_exchange_menu_btn)
	_lb.slot_index = _row * 2
	_lb.parent_bg = id
	var _rb = instance_create_depth(_rx + 255, _row_y + _by, depth-1, obj_exchange_menu_btn)
	_rb.slot_index = _row * 2 + 1
	_rb.parent_bg = id
}

exchange_recipes = [
	// slot 0: 左列第一行
	{"cost_gold":500, "cost_points":0, "cost_item_id":"clover_1", "cost_item_amount":5, "reward_item_id":"clover_2", "reward_item_amount":1},
	// slot 1: 右列第一行
	{"cost_gold":1000, "cost_points":0, "cost_item_id":"clover_2", "cost_item_amount":4, "reward_item_id":"clover_3", "reward_item_amount":1},
	// slot 2: 左列第二行
	{"cost_gold":2000, "cost_points":0, "cost_item_id":"clover_3", "cost_item_amount":4, "reward_item_id":"clover_4", "reward_item_amount":1},
	// slot 3: 右列第二行
	{"cost_gold":3000, "cost_points":0, "cost_item_id":"clover_4", "cost_item_amount":3, "reward_item_id":"clover_5", "reward_item_amount":1},
	// slot 4: 左列第三行
	{"cost_gold":5000, "cost_points":0, "cost_item_id":"clover_5", "cost_item_amount":3, "reward_item_id":"clover_6", "reward_item_amount":1},
	// slot 5: 右列第三行
	{"cost_gold":8000, "cost_points":0, "cost_item_id":"clover_6", "cost_item_amount":3, "reward_item_id":"clover_S", "reward_item_amount":1},
	// slot 6: 左列第四行
	{"cost_gold":1000, "cost_points":0, "cost_item_id":"less_crystal", "cost_item_amount":5, "reward_item_id":"middle_crystal", "reward_item_amount":1},
	// slot 7: 右列第四行
	{"cost_gold":8000, "cost_points":0, "cost_item_id":"middle_crystal", "cost_item_amount":10, "reward_item_id":"advanced_crystal", "reward_item_amount":1},
]

// 执行兑换
execute_exchange = function(_idx){
	if _idx < 0 || _idx >= array_length(exchange_recipes) { exit }
	var _r = exchange_recipes[_idx]
	// 检查金币
	if _r.cost_gold > 0 && global.save_data.player.gold < _r.cost_gold{
		show_notice("金币不足", 60)
		exit
	}
	// 检查点券
	if _r.cost_points > 0 && global.save_data.player.points < _r.cost_points{
		show_notice("点券不足", 60)
		exit
	}
	// 检查材料
	if _r.cost_item_id != "" && get_material_amount(_r.cost_item_id) < _r.cost_item_amount{
		show_notice("材料不足", 60)
		exit
	}
	// 扣款
	global.save_data.player.gold -= _r.cost_gold
	global.save_data.player.points -= _r.cost_points
	if _r.cost_item_id != ""{
		add_material_amount(_r.cost_item_id, -_r.cost_item_amount)
	}
	// 发放
	add_material_amount(_r.reward_item_id, _r.reward_item_amount)
	show_notice("兑换成功！", 60)
}