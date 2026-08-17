if global.is_paused{
	exit
}

event_inherited();

var current_flash_speed = flash_speed
if is_slowdown{
	current_flash_speed *= 2
}

// 变身倒计时
if transform_timer > 0 {
	transform_timer--
}

if shape >= 1 && transform_timer <= 55 && !exploded {
	exploded = true
	audio_play_sound(snd_coke_bomb_explode, 0, false);
	event_user(1)
}


// 变身完成：复制上一张放置的卡片
if transform_timer <= 0 && !is_derivative {
	var _blacklist = ["brahma", "magic_chicken", "ice_cream"]
	var _copy_count = 2
	if shape == 2 { _copy_count = 3 }
	else if shape == 3 { _copy_count = 5 }

	var _valid_target = (target_card != "" && array_get_index(_blacklist, target_card) == -1)

	var card_save_data = false
	if _valid_target {
		card_save_data = get_card_info_simple(target_card)
	}

	if card_save_data != false {
		var card_slot_data = deck_get_card_data(target_card, card_save_data.shape)
		var _copy_obj = card_slot_data[? "obj"]
		var _copy_plant_type = card_slot_data[? "plant_type"]
		var _copy_feature_type = card_slot_data[? "feature_type"]
		var _copy_target_card = card_slot_data[? "target_card"]

		// 第一个复制体直接放在brahma自身格位（复制后即自毁，格子必然可用）
		var target_cells = [[grid_col, grid_row]]
		var found_count = 1

		// 按 obj_hera shape>=3 的逻辑搜索周围空位补充剩余复制体
		var prev_replace = global.replace_placement
		global.replace_placement = false

		var max_dist = max(global.grid_cols, global.grid_rows)

		for (var d = 1; d <= max_dist; d++) {
			var candidates = []
			for (var dr = -d; dr <= d; dr++) {
				var dc_abs = d - abs(dr)
				if dc_abs == 0 {
					var col = grid_col
					var row = grid_row + dr
					if row >= 0 && row < global.grid_rows {
						if !(row == grid_row && col == grid_col) {
							var priority = (col == grid_col) ? 0 : ((row == grid_row) ? 1 : 2)
							array_push(candidates, { col: col, row: row, priority: priority })
						}
					}
				} else {
					for (var s = -1; s <= 1; s += 2) {
						var col = grid_col + s * dc_abs
						var row = grid_row + dr
						if row >= 0 && row < global.grid_rows && col >= 0 && col < global.grid_cols {
							if !(row == grid_row && col == grid_col) {
								var priority = (col == grid_col) ? 0 : ((row == grid_row) ? 1 : 2)
								array_push(candidates, { col: col, row: row, priority: priority })
							}
						}
					}
				}
			}

			array_sort(candidates, function(a, b) {
				if a.priority != b.priority return a.priority - b.priority
				if a.row != b.row return a.row - b.row
				return a.col - b.col
			})

			for (var i = 0; i < array_length(candidates); i++) {
				var cand = candidates[i]
				var xx = x + (cand.col - grid_col) * global.grid_cell_size_x
				var yy = y + (cand.row - grid_row) * global.grid_cell_size_y
				if can_place_at_position(xx, yy, _copy_plant_type, _copy_feature_type, _copy_target_card) {
					target_cells[found_count] = [cand.col, cand.row]
					found_count++
					if found_count >= _copy_count break
				}
			}
			if found_count >= _copy_count break
		}

		// 在找到的空位上创建复制体
		for (var i = 0; i < found_count; i++) {
			var cell = target_cells[i]
			var col = cell[0]
			var row = cell[1]
			var inst_x = x + (col - grid_col) * global.grid_cell_size_x
			var inst_y = y + (row - grid_row) * global.grid_cell_size_y
			var new_card = instance_create_depth(inst_x, inst_y, 0, _copy_obj)
			card_created(new_card, col, row)
		}

		global.replace_placement = prev_replace
	}

	// 复制完成后自毁
	instance_destroy()
}

