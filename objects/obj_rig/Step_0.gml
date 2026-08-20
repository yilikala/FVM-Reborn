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

//冷却计时器，没冷却完啥都不要干
if cooldown_timer > 0{
	cooldown_timer --;
	return;
}

if !attacking {
	// 检测自身右方是否有敌人，并获取最近的敌人
	with (obj_enemy_parent) {
	    if (grid_col > other.grid_col 
		&& can_target_on(other.target_type, target_type) 
		&& hp > 0 ) {
	        other.attacking = true;
	        break;
	    } 
	}
}

if attacking {
	state = CARD_STATE.ATTACK;
	attack_timer ++
	if attack_timer == (attack_anim - 10) * current_flash_speed {
		event_user(1);// 发射子弹
	}
	if attack_timer == (attack_anim - 7) * current_flash_speed && shape == 3 {
		event_user(1);// 发射子弹
	}
	if (attack_timer >= attack_anim * current_flash_speed || attack_timer >= cycle){
		attacking = false;
		cooldown_timer = cycle - attack_timer;
		attack_timer = 0;
		state = CARD_STATE.IDLE;
	}
}


