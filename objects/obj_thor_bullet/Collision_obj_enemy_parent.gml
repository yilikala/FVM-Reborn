if !hit_enemy{
	if other.hp > 0 and row == other.grid_row  and can_hit(target_type,other.target_type){
		with(other){
			audio_play_sound(snd_egg_bullet,0,0)
			damage_amount = other.damage
			damage_type = other.damage_type
			event_user(0)
			// 施加减速效果（600帧）
			if (other.slow_duration > 0){
				if (ice_timer < other.slow_duration){
					ice_timer = other.slow_duration
				}
			}
		}
		var _inst = instance_create_depth(x,y,depth,obj_eggboilerpult_bullet_effect)
		if(is_super){
			if(shape==2)_inst.sprite_index = spr_thor_bullet_effect_s
			else _inst.sprite_index = spr_thor_bullet_effect_s_1
		}
		else{ _inst.sprite_index = spr_thor_bullet_effect
		}
		_inst.hit_enemy = true
		_inst.hitted_enemy = other.id
		instance_destroy()
	}
}