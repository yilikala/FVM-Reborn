// 三线射手发射子弹的代码
var middle_y = y - 75; // 中间行的y坐标
var row_height = 100; // 行高，根据你的游戏调整

var _attire_id = card_equipped_attire_id(plant_id)
var _has_attire = (_attire_id != -1)
var _atk = atk

// 时装装备时的攻击力加成
if _has_attire {
	if shape == 0{
		_atk = round(atk * 1.2)
	}
	else if shape == 1 || shape == 2{
		_atk = round(atk * 1.5)
	}
}

// 时装shape0时需要中间多发一发（与原shape1行为一致）
var _extra_middle = (shape == 1)
if _has_attire && shape == 0{
	_extra_middle = true
}

// 创建三颗子弹，分别对应三行
var inst_middle = instance_create_depth(x + 40, middle_y, depth - 500, obj_triplewinerack_bullet);
inst_middle.damage = _atk;
inst_middle.move_speed = 8;
inst_middle.row = grid_row;
inst_middle.target_row = grid_row; // 目标行（中间行不变）

var inst_up = instance_create_depth(x + 40, middle_y, depth - 500, obj_triplewinerack_bullet);
inst_up.damage = _atk;
inst_up.move_speed = 8;
inst_up.row = grid_row;
if grid_row - 1 >= 0{
	inst_up.target_row = grid_row - 1; // 目标行（上一行）
}
else{
	inst_up.target_row = grid_row
	inst_up.x -= 20
}
inst_up.start_y = middle_y; // 记录起始y坐标

var inst_down = instance_create_depth(x + 40, middle_y, depth - 500, obj_triplewinerack_bullet);
inst_down.damage = _atk;
inst_down.move_speed = 8;
inst_down.row = grid_row;
if grid_row + 1 < global.grid_rows{
	inst_down.target_row = grid_row + 1; // 目标行（下一行）
}
else{
	inst_down.target_row = grid_row
	inst_down.x -= 20
}
inst_down.start_y = middle_y; // 记录起始y坐标

if _extra_middle{
	var inst_middle2 = instance_create_depth(x + 80, middle_y, depth - 500, obj_triplewinerack_bullet);
	inst_middle2.damage = _atk;
	inst_middle2.move_speed = 8;
	inst_middle2.row = grid_row;
	inst_middle2.target_row = grid_row; // 目标行（中间行不变）
	if _attire_id == "wine_rack_sagittarius"{
		inst_middle2.sprite_index = spr_wine_rack_sagittarius_bullet
		if shape >= 2{
			inst_middle2.sprite_index = spr_wine_rack_sagittarius_bullet_1
		}
	}
}

if _attire_id == "wine_rack_sagittarius"{
	inst_up.sprite_index = spr_wine_rack_sagittarius_bullet
	inst_middle.sprite_index = spr_wine_rack_sagittarius_bullet
	inst_down.sprite_index = spr_wine_rack_sagittarius_bullet
	if shape >= 2{
		inst_up.sprite_index = spr_wine_rack_sagittarius_bullet_1
		inst_middle.sprite_index = spr_wine_rack_sagittarius_bullet_1
		inst_down.sprite_index = spr_wine_rack_sagittarius_bullet_1
	}
}

audio_play_sound(snd_shot, 0, 0);