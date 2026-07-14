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
	if (grid_row >= other.grid_row-1&&grid_row <= other.grid_row+1 && grid_col >= other.grid_col && grid_col <= (global.grid_cols + 1) && can_target_on(other.target_type,target_type)){
		has_enemy = true
		break
	}
}

if (has_enemy) {
	var total_bursts = 2
	if shape >= 1 { total_bursts = 3 }
	
	if (attack_timer <= cycle - attack_anim * current_flash_speed) {
		attack_timer++;
	} else if (attack_timer <= cycle) {
		attack_timer++;
		state = CARD_STATE.ATTACK;
		
		if (attack_timer == cycle - 3*current_flash_speed){
			event_user(1);
		}
		if total_bursts >= 2 && (attack_timer == cycle - 2*current_flash_speed){
			event_user(1)
		}
		if total_bursts >= 3 && (attack_timer == cycle - 1*current_flash_speed){
			event_user(1)
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
