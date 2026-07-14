if global.is_paused{
	exit
}
event_inherited();
if is_frozen || state == CARD_STATE.SLEEP{
	exit
}
var current_flash_speed = flash_speed
if is_slowdown{
	current_flash_speed *= 2
}

var hp_ratio = hp / max_hp
if shape == 0{
	if hp_ratio > 0.66 { sprite_index = spr_hera_outer_1 }
	else if hp_ratio > 0.33 { sprite_index = spr_hera_outer_2 }
	else { sprite_index = spr_hera_outer_3 }
}
else if shape == 1{
	if hp_ratio > 0.66 { sprite_index = spr_hera_1_outer_1 }
	else if hp_ratio > 0.33 { sprite_index = spr_hera_1_outer_2 }
	else { sprite_index = spr_hera_1_outer_3 }
}
else if shape == 2{
	if hp_ratio > 0.66 { sprite_index = spr_hera_2_outer_1 }
	else if hp_ratio > 0.33 { sprite_index = spr_hera_2_outer_2 }
	else { sprite_index = spr_hera_2_outer_3 }
}
else{
	if hp_ratio > 0.66 { sprite_index = spr_hera_3_outer_1 }
	else if hp_ratio > 0.33 { sprite_index = spr_hera_3_outer_2 }
	else { sprite_index = spr_hera_3_outer_3 }
}

if current_hp > hp {
	bleed_damage = current_hp - hp
	event_user(1)
}

if shape >= 3 && !is_derivative {
    var prev_replace = global.replace_placement;
    global.replace_placement = false;

    var target_cells = [];          // 存放找到的空位 [col, row]
    var max_dist = max(global.grid_cols, global.grid_rows);
    var found_count = 0;

    // 曼哈顿距离从 1 开始递增搜索
    for (var d = 1; d <= max_dist; d++) {
        var candidates = [];
        // 生成距离为 d 的所有格子，并计算优先级
        for (var dr = -d; dr <= d; dr++) {
            var dc_abs = d - abs(dr);
            if (dc_abs == 0) {
                var col = grid_col;
                var row = grid_row + dr;
                if (row >= 0 && row < global.grid_rows) {
                    if (!(row == grid_row && col == grid_col)) {
                        var priority = (col == grid_col) ? 0 : ((row == grid_row) ? 1 : 2);
                        array_push(candidates, { col: col, row: row, priority: priority });
                    }
                }
            } else {
                for (var s = -1; s <= 1; s += 2) {
                    var col = grid_col + s * dc_abs;
                    var row = grid_row + dr;
                    if (row >= 0 && row < global.grid_rows && col >= 0 && col < global.grid_cols) {
                        if (!(row == grid_row && col == grid_col)) {
                            var priority = (col == grid_col) ? 0 : ((row == grid_row) ? 1 : 2);
                            array_push(candidates, { col: col, row: row, priority: priority });
                        }
                    }
                }
            }
        }

        // 按优先级排序：上下（0） > 左右（1） > 对角（2）
        array_sort(candidates, function(a, b) {
            if (a.priority != b.priority) return a.priority - b.priority;
            if (a.row != b.row) return a.row - b.row;
            return a.col - b.col;
        });

        // 依次检查每个候选格是否可放置
        for (var i = 0; i < array_length(candidates); i++) {
            var cand = candidates[i];
            var xx = x + (cand.col - grid_col) * global.grid_cell_size_x;
            var yy = y + (cand.row - grid_row) * global.grid_cell_size_y;
            if (can_place_at_position(xx, yy, "shield_outer", "normal", "none")) {
                target_cells[found_count] = [cand.col, cand.row];
                found_count++;
                if (found_count >= 2) break;
            }
        }
        if (found_count >= 2) break;
    }

    // 在找到的空位上创建复制体
    for (var i = 0; i < found_count; i++) {
        var cell = target_cells[i];
        var col = cell[0];
        var row = cell[1];
        var inst_x = x + (col - grid_col) * global.grid_cell_size_x;
        var inst_y = y + (row - grid_row) * global.grid_cell_size_y;
        var inst = instance_create_depth(inst_x, inst_y, depth + 5, obj_hera);
        inst.is_derivative = true;
        card_created(inst, col, row);   // 传递新格子的列、行
    }

    global.replace_placement = prev_replace;
    is_derivative = true;
}

current_hp = hp
