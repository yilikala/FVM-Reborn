if global.is_paused{
	exit
}

var current_flash_speed = flash_speed
if is_slowdown{
	current_flash_speed *= 2
}

event_inherited(); 

if is_frozen || state == CARD_STATE.SLEEP{
	exit
}

//冷却计时器，没冷却完啥都不要干
if cooldown_timer > 0{
	cooldown_timer --;
	state = CARD_STATE.IDLE;
	exit;
}

var has_enemy = false
var target_enemy = noone

if !attacking {
	// 检测自身右方是否有敌人，并获取最近的敌人
	var min_distance = 10000 // 设置一个足够大的初始值
	var row_offset = (shape == 3) ? 2 : 1

	with(obj_enemy_parent){
		if (
        grid_row >= other.grid_row - row_offset 
        && grid_row <= other.grid_row + row_offset
        && grid_col <= (global.grid_cols + 1) 
        && can_target_on(other.target_type, target_type)
		){
		    var distance = grid_col - other.grid_col
		    if (distance < min_distance) {
		        min_distance = distance
		        target_enemy = id
		        has_enemy = true
		    }
		}
	}
}

// 存储目标敌人信息
if (has_enemy) {
    target_x = target_enemy.x;
	attacking = true;
}

if attacking {
	state = CARD_STATE.ATTACK;
	attack_timer ++
	if attack_timer == (attack_anim - 10) * current_flash_speed {
		event_user(1);// 发射子弹
	}
	if attack_timer == (attack_anim - 8) * current_flash_speed {
		event_user(1);// 发射子弹
	}
	if attack_timer == (attack_anim - 6) * current_flash_speed {
		event_user(1);// 发射子弹
	}
	if attack_timer >= attack_anim * current_flash_speed {
		attacking = false;
		cooldown_timer = cycle - attack_timer;
		attack_timer = 0;
		target_x = noone;
	}
}
