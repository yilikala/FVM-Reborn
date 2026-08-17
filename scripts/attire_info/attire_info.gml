///@function is_attire_unlocked(attire_id)
///@description 判断时装是否解锁
///@param {string}attire_id 时装id
///@return {bool}
function is_attire_unlocked(attire_id){
	var attire_list = global.save_data.attires
	for(var i = 0 ; i < array_length(attire_list) ; i++){
		if attire_list[i].attire_id == attire_id{
			return true
		}
	}
	return false
}

///@function card_equipped_attire_id(card_id)
///@description 找到卡片已装备的时装id。如果没有则返回-1。
///@param {string}card_id 卡片id
///@return {string}
function card_equipped_attire_id(card_id){
	var attire_list = global.save_data.attires
	for(var i = 0 ; i < array_length(attire_list) ; i++){
		var attire_data = get_attire_info(attire_list[i].attire_id)
		if attire_data.target_card == card_id && attire_list[i].state == "equipped"{
			return attire_list[i].attire_id
		}
	}
	//如果没有找到对应时装，则返回-1
	return -1
}

///@function unlock_attire(attire_id)
///@description 解锁时装
///@param {string}attire_id 时装id
function unlock_attire(attire_id){
	//在时装数组中添加对应时装
	if !is_attire_unlocked(attire_id){
		array_push(global.save_data.attires,{"attire_id":attire_id,"state":"unequipped"})
	}
}

///@function get_attire_state(attire_id)
///@description 判断时装装备状态。如果未解锁则返回-1。
///@param {string}attire_id 时装id
///@return {string}
function get_attire_state(attire_id){
	//未解锁则返回-1
	if !is_attire_unlocked(attire_id){
		return -1
	}
	//在时装数组中寻找对应时装并返回状态
	var attire_list = global.save_data.attires
	for(var i = 0 ; i < array_length(attire_list) ; i++){
		if attire_list[i].attire_id == attire_id{
			return attire_list[i].state
		}
	}
}

///@function edit_attire_state(attire_id,new_state)
///@description 修改时装装备状态
///@param {string}attire_id 时装id
///@param {string}new_state 新状态
function edit_attire_state(attire_id,new_state){
	//未解锁则立即退出
	if !is_attire_unlocked(attire_id){
		return
	}
	//在时装数组中寻找对应时装并修改状态
	var attire_list = global.save_data.attires
	for(var i = 0 ; i < array_length(attire_list) ; i++){
		if attire_list[i].attire_id == attire_id{
			global.save_data.attires[i].state = new_state
		}
	}
}

///@function get_card_attire_list(card_id)
///@description 获取一张卡片的全部时装列表
///@param {string}card_id 卡片id
///@return {array}
function get_card_attire_list(card_id){
	var attire_id_list = []
	//遍历时装数组寻找目标卡片为card_id的时装
	var attire_list = global.save_data.attires
	for(var i = 0 ; i < array_length(attire_list) ; i++){
		var attire_data = get_attire_info(attire_list[i].attire_id)
		if attire_data.target_card == card_id{
			//如果找到，加入到时装id数组中
			array_push(attire_id_list,attire_list[i].attire_id)
		}
	}
	return attire_id_list
}

///@function equip_attire(attire_id)
///@description 装备时装
///@param {string}attire_id 要装备的时装id
function equip_attire(attire_id){
	//如果未解锁则退出
	if !is_attire_unlocked(attire_id){
		return
	}
	//获取卡片对应的全部时装
	var attire_data = get_attire_info(attire_id)
	var attire_id_list = get_card_attire_list(attire_data.target_card)
	//将其他时装全部设置为未装备
	for(var i = 0 ; i < array_length(attire_id_list) ; i++){
		edit_attire_state(attire_id_list[i],"unequipped")
	}
	//将自身设置为已装备
	edit_attire_state(attire_id,"equipped")
	//应用卡片数据覆盖
	apply_attire_card_overrides(attire_data.target_card)
}

///@function unequip_attire(attire_id)
///@description 取消装备时装
///@param {string}attire_id 要取消的时装id
function unequip_attire(attire_id){
	//如果未解锁则退出
	if !is_attire_unlocked(attire_id){
		return
	}
	//将自身设置为未装备
	edit_attire_state(attire_id,"unequipped")
	//恢复卡片原始数据
	var attire_data = get_attire_info(attire_id)
	apply_attire_card_overrides(attire_data.target_card)
}

///@function apply_attire_card_overrides(card_id)
///@description 根据时装装备状态应用或恢复卡片的cost/卡槽贴图/名称/描述覆盖
///@param {string}card_id 卡片id
function apply_attire_card_overrides(card_id){
	var attire_id = card_equipped_attire_id(card_id)
	var has_overrides = false
	var attire_data = undefined

	if attire_id != -1 {
		attire_data = get_attire_info(attire_id)
		if variable_struct_exists(attire_data, "card_overrides"){
			has_overrides = true
		}
	}

	//在 player_deck 中找到该卡片的索引
	var deck_index = -1
	for(var i = 0; i < ds_list_size(global.player_deck); i += 2){
		if global.player_deck[| i] == card_id {
			deck_index = i
			break
		}
	}
	if deck_index == -1 exit

	var card_entry = global.player_deck[| deck_index + 1]
	var shapes = card_entry[? "shapes"]
	var num_shapes = ds_list_size(shapes)

	//初始化备份全局变量
	if !variable_global_exists("attire_card_overrides_backup"){
		global.attire_card_overrides_backup = ds_map_create()
	}
	var backup = undefined
	if ds_map_exists(global.attire_card_overrides_backup, card_id){
		backup = global.attire_card_overrides_backup[? card_id]
	}

	if has_overrides {
		//首次应用时备份原始值
		if backup == undefined {
			backup = { "cost":[], "description":[], "is_special":[], "name":[], "sprite":[], "cooldown":[], "reg_cost":[], "reg_cooldown":[] }
			for(var s = 0; s < num_shapes; s++){
				var shape_data = shapes[| s]
				backup.cost[s] = shape_data[? "cost"]
				backup.description[s] = shape_data[? "description"]
				backup.is_special[s] = ds_map_exists(shape_data, "is_special") ? shape_data[? "is_special"] : 0
				backup.sprite[s] = shape_data[? "sprite"]
				backup.cooldown[s] = shape_data[? "cooldown"]
				var plant_data = global.plant_registry[? card_id]
				var plant_shapes = plant_data[? "shapes"]
				if ds_map_exists(plant_shapes, string(s)){
					backup.name[s] = plant_shapes[? string(s)][? "name"]
					backup.reg_cost[s] = plant_shapes[? string(s)][? "base_cost"]
					backup.reg_cooldown[s] = plant_shapes[? string(s)][? "base_cooldown"]
				}
			}
			global.attire_card_overrides_backup[? card_id] = backup
		}

		//应用覆盖值
		var overrides = attire_data.card_overrides
		var name_overrides = variable_struct_exists(attire_data, "name_overrides") ? attire_data.name_overrides : undefined
		var has_slot_icon = variable_struct_exists(attire_data, "card_slot_icon")
		for(var s = 0; s < num_shapes; s++){
			var shape_key = string(s)
			var shape_data = shapes[| s]
			if variable_struct_exists(overrides, shape_key){
				var shape_override = variable_struct_get(overrides, shape_key)
				if variable_struct_exists(shape_override, "cost"){
					shape_data[? "cost"] = shape_override.cost
					//同步覆盖 plant_registry（战斗中植物实例的实际数据来源）
					if ds_map_exists(global.plant_registry, card_id){
						var _ps = global.plant_registry[? card_id][? "shapes"]
						if ds_map_exists(_ps, shape_key){
							var _rs = _ps[? shape_key]
							_rs[? "base_cost"] = shape_override.cost
							var _ups = _rs[? "upgrades"]
							var _lk = ds_map_keys_to_array(_ups)
							for (var _l = 0; _l < array_length(_lk); _l++){
								_ups[? _lk[_l]][? "cost"] = shape_override.cost
							}
						}
					}
				}
				if variable_struct_exists(shape_override, "description"){
					shape_data[? "description"] = shape_override.description
				}
				if variable_struct_exists(shape_override, "is_special"){
					shape_data[? "is_special"] = shape_override.is_special
				}
				if variable_struct_exists(shape_override, "cooldown"){
					shape_data[? "cooldown"] = shape_override.cooldown
					//同步覆盖 plant_registry
					if ds_map_exists(global.plant_registry, card_id){
						var _ps = global.plant_registry[? card_id][? "shapes"]
						if ds_map_exists(_ps, shape_key){
							var _rs = _ps[? shape_key]
							_rs[? "base_cooldown"] = shape_override.cooldown
							var _ups = _rs[? "upgrades"]
							var _lk = ds_map_keys_to_array(_ups)
							for (var _l = 0; _l < array_length(_lk); _l++){
								_ups[? _lk[_l]][? "cooldown"] = shape_override.cooldown
							}
						}
					}
				}
			}
			//覆盖卡片图标贴图（与战斗中 obj_card_slot 行为一致）
			if has_slot_icon && s < array_length(attire_data.card_slot_icon){
				shape_data[? "sprite"] = attire_data.card_slot_icon[s]
			}
			if name_overrides != undefined && variable_struct_exists(name_overrides, shape_key){
				var plant_data = global.plant_registry[? card_id]
				var plant_shapes = plant_data[? "shapes"]
				if ds_map_exists(plant_shapes, shape_key){
					plant_shapes[? shape_key][? "name"] = variable_struct_get(name_overrides, shape_key)
				}
			}
		}
	}
	else {
		//恢复原始值
		if backup != undefined {
		for(var s = 0; s < num_shapes; s++){
			var shape_data = shapes[| s]
			shape_data[? "cost"] = backup.cost[s]
			shape_data[? "description"] = backup.description[s]
			shape_data[? "sprite"] = backup.sprite[s]
			shape_data[? "cooldown"] = backup.cooldown[s]
			if backup.is_special[s] != 0 {
				shape_data[? "is_special"] = backup.is_special[s]
			}
			else {
				ds_map_delete(shape_data, "is_special")
			}
		var plant_data = global.plant_registry[? card_id]
		var plant_shapes = plant_data[? "shapes"]
		if ds_map_exists(plant_shapes, string(s)){
			plant_shapes[? string(s)][? "name"] = backup.name[s]
			//恢复 plant_registry 的 cost/cooldown
			var _rs = plant_shapes[? string(s)]
			if backup.reg_cost[s] != undefined {
				_rs[? "base_cost"] = backup.reg_cost[s]
				var _ups = _rs[? "upgrades"]
				var _lk = ds_map_keys_to_array(_ups)
				for (var _l = 0; _l < array_length(_lk); _l++){
					_ups[? _lk[_l]][? "cost"] = backup.reg_cost[s]
				}
			}
			if backup.reg_cooldown[s] != undefined {
				_rs[? "base_cooldown"] = backup.reg_cooldown[s]
				var _ups = _rs[? "upgrades"]
				var _lk = ds_map_keys_to_array(_ups)
				for (var _l = 0; _l < array_length(_lk); _l++){
					_ups[? _lk[_l]][? "cooldown"] = backup.reg_cooldown[s]
				}
			}
		}
		}
		}
	}
}
