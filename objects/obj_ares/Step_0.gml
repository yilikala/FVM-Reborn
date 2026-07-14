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
with(obj_enemy_parent){
	if (grid_row == other.grid_row && grid_col <= (global.grid_cols + 1)) && can_target_on(other.target_type,target_type){
		has_enemy = true
		break
	}
}

if (has_enemy) {
	var total_bursts = 4
	if shape >= 1 { total_bursts = 5 }
	if shape >= 2 { total_bursts = 6 }
	
	if (attack_timer <= cycle - attack_anim * current_flash_speed) {
		attack_timer++;
	} else if (attack_timer <= cycle) {
		attack_timer++;
		state = CARD_STATE.ATTACK;
		
		if b_count < total_bursts {
			var fire_time = cycle - (7 - b_count) * current_flash_speed
			if attack_timer == fire_time {
				event_user(1)
			}
		}
	} else {
		attack_timer = 0;
		state = CARD_STATE.IDLE;
		b_count = 0
	}
} else {
	attack_timer = 0;
	state = CARD_STATE.IDLE;
	b_count = 0
}
