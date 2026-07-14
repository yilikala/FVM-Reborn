b_count++

var bulllet_spr = spr_cupid_bulllet
if shape >= 1 { bulllet_spr = spr_cupid_bulllet_1 }
if shape >= 2 { bulllet_spr = spr_cupid_bulllet_2 }
if shape >= 3 { bulllet_spr = spr_cupid_bulllet_3 }

var fire_sides = true
if shape == 1 && b_count == 3 {
	fire_sides = false
}

var is_super = false
if shape >= 3 && b_count == 1 {
	is_super = true
}

var bullet_obj = obj_cupid_bullet
if is_super { bullet_obj = obj_cupid_bullet_s }

var middle_y = y - 75;
var row_height = 100;

var inst_middle = instance_create_depth(x + 40, middle_y, depth - 500, bullet_obj);
inst_middle.damage = atk;
inst_middle.move_speed = 8;
inst_middle.row = grid_row;
inst_middle.target_row = grid_row;
inst_middle.sprite_index = bulllet_spr
if is_super {
	inst_middle.sprite_index = spr_cupid_bulllet_s
}

if fire_sides {
	var inst_up = instance_create_depth(x + 40, middle_y, depth - 500, bullet_obj);
	inst_up.damage = atk;
	inst_up.move_speed = 8;
	inst_up.row = grid_row;
	if grid_row - 1 >= 0{
		inst_up.target_row = grid_row - 1;
	}
	else{
		inst_up.target_row = grid_row
		inst_up.x -= 20
	}
	inst_up.start_y = middle_y;
	inst_up.sprite_index = bulllet_spr
	if is_super {
		inst_up.sprite_index = spr_cupid_bulllet_s
	}

	var inst_down = instance_create_depth(x + 40, middle_y, depth - 500, bullet_obj);
	inst_down.damage = atk;
	inst_down.move_speed = 8;
	inst_down.row = grid_row;
	if grid_row + 1 < global.grid_rows{
		inst_down.target_row = grid_row + 1;
	}
	else{
		inst_down.target_row = grid_row
		inst_down.x -= 20
	}
	inst_down.start_y = middle_y;
	inst_down.sprite_index = bulllet_spr
	if is_super {
		inst_down.sprite_index = spr_cupid_bulllet_s
	}
}

audio_play_sound(snd_shot, 0, 0);
