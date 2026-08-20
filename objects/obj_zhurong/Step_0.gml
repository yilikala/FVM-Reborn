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
	return;
}

var has_enemy = false
var target_enemy = noone

if !attacking {
	// 检测自身右方是否有敌人，并获取最近的敌人
	var min_distance = 10000 // 设置一个足够大的初始值
	var row_offset = 1
	if shape >= 3 row_offset = 3;
	else if shape >= 2 row_offset = 2;

	with(obj_enemy_parent){
		if (abs(grid_row - other.grid_row) <= row_offset
		&& grid_col >= other.grid_col 
		&& grid_col <= (global.grid_cols + 1) 
		&& can_target_on(other.target_type,target_type)){
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
    target_instance = target_enemy;
	attacking = true;
}

if attacking {
	state = CARD_STATE.ATTACK;
	attack_timer ++
	if attack_timer == attack_anim * flash_speed - 20 {
		event_user(1);// 发射子弹
	}
	if attack_timer >= attack_anim * flash_speed {
		attacking = false;
		cooldown_timer = cycle - attack_timer;
		attack_timer = 0;
		target_instance = noone;
		state = CARD_STATE.IDLE
	}
}

