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

track_timer++
if track_timer >= 3 {
	track_timer = 0
	track_target = track_find_best_target(id)
}

var has_enemy = false
if instance_exists(obj_enemy_parent){
	with obj_enemy_parent{
		if can_target_on(other.target_type,target_type){
			has_enemy = true
		}
	}
}

if (has_enemy) {
	if (attack_timer <= cycle - attack_anim * current_flash_speed) {
		attack_timer++;
	} else if (attack_timer <= cycle) {
		attack_timer++;
		state = CARD_STATE.ATTACK;
	} else {
		event_user(1);
		attack_timer = 0;
		state = CARD_STATE.IDLE;
	}
	if (attack_timer == cycle - 6*flash_speed){
		event_user(1);
	}
} else {
	attack_timer = 0;
	state = CARD_STATE.IDLE;
}
