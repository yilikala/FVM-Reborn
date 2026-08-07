

	if other.hp > 0 and target_enemy == other.id  and can_hit(target_type,other.target_type){
		with(other){
			
			audio_play_sound(hit_sound,0,0)
			
			damage_amount = other.damage
			damage_type = other.damage_type
			event_user(0)
	
		}

			instance_create_depth(x,y,depth,obj_takoyaki_bullet_effect)
		
		// 溅射伤害：对命中点周围敌人造成溅射
		if is_splash && splash_ratio > 0{
			var _hit_x = x
			var _hit_y = y
			var _splash_damage = round(damage * splash_ratio)
			with (obj_enemy_parent) {
				if (hp > 0 && id != other.target_enemy
					&& point_distance(x, y, _hit_x, _hit_y) < 180
					&& can_hit(other.target_type, target_type)) {
					damage_amount = _splash_damage
					damage_type = other.damage_type
					event_user(0)
				}
			}
		}
		instance_destroy()
	}
