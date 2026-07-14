if global.is_paused{
	exit
}
if state == CARD_STATE.IDLE{
	flash_speed = 5
}
else if state == CARD_STATE.ATTACK{
	flash_speed = 4
}
event_inherited();
if is_frozen || state == CARD_STATE.SLEEP{
	exit
}
var current_flash_speed = flash_speed
if is_slowdown{
	current_flash_speed *= 2
}

var total_attacks = 1
if shape <= 1 { total_attacks = 2 }
if shape == 2 { total_attacks = 3 }
if shape == 3 { total_attacks = 4 }

var _x = x;
var _y = y;
var _row = grid_row
var _hw = global.grid_cell_size_x * 2.5
var _hr = 2
if shape == 3 { _hr = 3 }

var has_enemy = false
with (obj_enemy_parent) {
	if (can_target_on(other.target_type, target_type) && abs(grid_row - _row) <= _hr && abs(x - _x) <= _hw) {
		has_enemy = true
	}
}

if (has_enemy || attack_timer > 0) {
	if (attack_timer <= cycle - attack_anim * current_flash_speed) {
		attack_timer++;
	} else if (attack_timer < cycle) {
		attack_timer++;
		state = CARD_STATE.ATTACK;
	} else {
		attack_timer = 0;
		state = CARD_STATE.IDLE;
	}

	if (attack_timer == cycle - 12*current_flash_speed){
		event_user(1);
		audio_play_sound(snd_coffee_pot_attack, 0, 0);
	}
	if total_attacks >= 2 && (attack_timer == cycle - 9*current_flash_speed){
		event_user(1);
	}
	if total_attacks >= 3 && (attack_timer == cycle - 6*current_flash_speed){
		event_user(1);
	}
	if total_attacks >= 4 && (attack_timer == cycle - 3*current_flash_speed){
		event_user(1);
	}
} else {
	attack_timer = 0;
	state = CARD_STATE.IDLE;
}
