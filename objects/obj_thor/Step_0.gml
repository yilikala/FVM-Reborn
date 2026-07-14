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

var has_enemy = false
var target_enemy = noone
var min_distance = 10000

with(obj_enemy_parent){
	if (grid_row == other.grid_row && grid_col >= other.grid_col && grid_col <= (global.grid_cols + 1) && can_target_on(other.target_type,target_type)){
		var distance = grid_col - other.grid_col
		if (distance < min_distance) {
			min_distance = distance
			target_enemy = id
			has_enemy = true
		}
	}
}

if (!has_enemy) {
	with(obj_enemy_parent){
		if (target_type == "air" && grid_row == other.grid_row && grid_col >= other.grid_col && grid_col <= (global.grid_cols + 1)){
			var distance = grid_col - other.grid_col
			if (distance < min_distance) {
				min_distance = distance
				target_enemy = id
				has_enemy = true
			}
		}
	}
}

if (has_enemy) {
	target_instance = target_enemy
} else {
	target_instance = noone
}

if (has_enemy) {
	// 计算子弹总数
	var total_bullets = 2
	if shape >= 1 {
		total_bullets = 3
	}
	if shape == 3 {
		total_bullets = 4
	}
	if shape == 2 and (attack_counter % 3 == 0) {
		total_bullets = 4
	}

	if (attack_timer <= cycle - attack_anim * current_flash_speed) {
		attack_timer++;
	} else if (bullet_fired_count < total_bullets) {
		var fire_time = cycle - 30 + bullet_fired_count * 7
		if (attack_timer == fire_time) {
			is_super_bullet = false
			if (bullet_fired_count == 0) {
				if (shape >= 3 or (shape == 2 and attack_counter % 3 == 0)) {
					is_super_bullet = true
				}
			}
			event_user(1);
			bullet_fired_count++
		}
		attack_timer++;
		state = CARD_STATE.ATTACK;
	} else if (attack_timer <= cycle) {
		attack_timer++;
		state = CARD_STATE.ATTACK;
	} else {
		attack_timer = 0;
		bullet_fired_count = 0
		if (shape >= 2) {
			attack_counter++
		}
		state = CARD_STATE.IDLE;
	}
} else {
	attack_timer = 0;
	bullet_fired_count = 0
	state = CARD_STATE.IDLE;
}
