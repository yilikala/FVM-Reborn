if other.hp > 0 and row == other.grid_row and can_hit(target_type, other.target_type) and ds_list_find_index(hitted_enemy, other.id) == -1{
	ds_list_add(hitted_enemy, other.id)

	// 直接伤害
	with(other){
		audio_play_sound(snd_egg_bullet, 0, 0)
		damage_amount = other.damage
		damage_type = other.damage_type
		event_user(0)
	}

	// 溅射 + 毒雾 + 定身（排除直接目标）
	egg_god_do_splash(damage, other.x, other.y, other.id)

	if !bounced{
		// 弹跳一次：80% 伤害
		bounced = true
		damage *= 0.8
		// 弹跳到敌人身后一格的抛物线
		var _bx = other.x + global.grid_cell_size_x
		var _flight = 30
		var _dx = _bx - x
		var _dy = 300
		move_speed = _dx / _flight
		cgravity = (2 * _dy) / (_flight * _flight)
		cvspeed = _dy / _flight
	}
	else{
		// 弹跳后再次命中 → 销毁
		instance_destroy()
	}
}
