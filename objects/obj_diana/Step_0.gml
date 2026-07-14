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

if shape == 3 {
	var diana_count = 0
	with(obj_diana){
		diana_count++
	}
	var mult = 1 + min(diana_count * 0.05, 1)
	atk = round(base_atk * mult)
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
	if (attack_timer == cycle - 1*flash_speed){
		event_user(1);
	}
	if (attack_timer == cycle - 2*flash_speed){
		event_user(1);
	}
	if (attack_timer == cycle - 3*flash_speed){
		event_user(1);
	}
	if (attack_timer == cycle - 4*flash_speed){
		event_user(1);
	}
	if (attack_timer == cycle - 5*flash_speed){
		event_user(1);
	}
	if (shape>1&&attack_timer == cycle - 6*flash_speed){
		if shape==1 event_user(1);
		else event_user(3);
	}
} else {
	attack_timer = 0;
	state = CARD_STATE.IDLE;
}

