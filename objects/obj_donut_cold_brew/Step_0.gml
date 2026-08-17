if global.is_paused{
	exit
}
event_inherited()

var has_enemy = false
with(obj_enemy_parent){
	if can_target_on("split", target_type) && hp > 0 {
		has_enemy = true
		break
	}
}
if has_enemy {
	attack_timer++
	if attack_timer > cycle - attack_anim * flash_speed {
		state = CARD_STATE.ATTACK
	}
	if attack_timer > cycle {
		audio_play_sound(snd_throw, 0, 0)
		event_user(1)
		attack_timer = 0
		state = CARD_STATE.IDLE
	}
} else {
	attack_timer = 0
	state = CARD_STATE.IDLE
}
if fire_cd > 0 {
	fire_cd--
} else if array_length(fire_queue) > 0 {
	var _e = fire_queue[0]
	array_delete(fire_queue, 0, 1)
	if instance_exists(_e) && _e.hp > 0 {
		var _spd = _e.move_speed * _e.move_speed_modify
		if _e.is_slowdown { _spd *= 0.5 }
		if _e.is_frozen || _e.is_stun || _e.is_scare { _spd = 0 }
		var _pred_x = _e.x - _spd * explode_timer
		var _spawn_y = y - 500
		for (var _i = 0; _i < 3; _i++) {
			var _ox = _i * 50 - 50
			var inst = instance_create_depth(_pred_x, _spawn_y - _ox, depth - 500, obj_donut_cold_brew_bullet)
			inst.damage = atk
			inst.target_enemy = _e
			inst.pred_row = _e.grid_row
		}
	}
	fire_cd = fire_interval
}

