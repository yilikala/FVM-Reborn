if global.is_paused{
	exit
}

// 动画计时器
if timer < flash_speed - 1 {
	timer++;
} else {
	switch (state) {
		case CARD_STATE.IDLE:
			if image_index < 7 image_index++;
			else image_index = 0;
		break;
            
		case CARD_STATE.ATTACK:
			if (image_index >= (7+1) && image_index <= (7+1) + attack_anim) image_index++;
			else image_index = (7+1);
		break;
		
	}
	timer = 0;
}

// 计算深度值
depth = parent_player.depth-2

//检测场上是否有敌人
var has_enemy = false
with(obj_enemy_parent){
	if (can_hit("all",target_type) && hp > 0){
		has_enemy = true
		break
	}
}

// 攻击逻辑
if (has_enemy) {
    attack_timer++;

    // 进入攻击阶段
    if (attack_timer > cycle - attack_anim * flash_speed) {
        state = CARD_STATE.ATTACK;
    }

    // 一个周期结束：构建发射队列（所有子弹在这几帧内逐颗生成）
    if (attack_timer > cycle) {
        event_user(1);   // 构建 fire_queue
        attack_timer = 0;
        state = CARD_STATE.IDLE;
    }

} else {
    attack_timer = 0;
    state = CARD_STATE.IDLE;
}

// 逐颗发射：每隔 fire_interval 帧从队列中取一个目标生成子弹
if fire_cd > 0{
	fire_cd--
}
else if array_length(fire_queue) > 0{
	var _e = fire_queue[0]
	array_delete(fire_queue, 0, 1)

	if instance_exists(_e) && _e.hp > 0{
		// 计算预测落点（根据敌人速度与剩余帧数）
		var _spd = _e.move_speed * _e.move_speed_modify
		if _e.is_slowdown{ _spd *= 0.5 }
		if _e.is_frozen || _e.is_stun || _e.is_scare{ _spd = 0 }
		var _pred_x = _e.x - _spd * explode_timer
		var _pred_y = _e.y - 5

		// 生成纯动画子弹（不携带伤害）
		var inst = instance_create_depth(_pred_x, _pred_y, depth-500, obj_star_wand_bullet)
		inst.target_enemy = _e
		inst.sprite_index = bullet_shape
		inst.explode_timer = explode_timer

		// 记录延迟伤害（爆炸时才生效，全部在武器本体处理）
		var _hit = {}
		_hit.x = _pred_x
		_hit.y = _pred_y
		_hit.target = _e
		_hit.frames = explode_timer
		array_push(pending_hits, _hit)
	}

	fire_cd = fire_interval
}

for(var i = 0; i < array_length(pending_hits); i++){
	var _h = pending_hits[i]
	_h.frames--
	if _h.frames <= 0{
		cur_hit = _h

		// 直接伤害目标
		if instance_exists(_h.target) && _h.target.hp > 0{
			with(_h.target){
				audio_play_sound(snd_star_wand,0,0)
				damage_amount = other.atk
				damage_type = other.damage_type
				event_user(0)
			}
			// 眩晕几率
			if irandom_range(1,100) <= diz_chance * 100{
				_h.target.stun_timer = 180
			}
		}

		if splash_ratio > 0{
			with(obj_enemy_parent){
				if hp > 0 && id != other.cur_hit.target{
					var _gcell = get_grid_position_from_world(other.cur_hit.x, other.cur_hit.y)
					if grid_row >= _gcell.row - 1 && grid_row <= _gcell.row + 1
						&& (abs(other.cur_hit.x-x)<=180){
						audio_play_sound(snd_star_wand,0,0)
						damage_amount = round(other.atk * other.splash_ratio)
						damage_type = other.damage_type
						event_user(0)
					}
				}
			}
		}

		array_delete(pending_hits, i, 1)
		i--
	}
}
