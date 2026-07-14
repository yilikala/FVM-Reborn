

if other.hp > 0 && target_enemy == other.id && can_hit(target_type, other.target_type){
	if is_super {
		var _damage = damage * 2
		var _hit_id = other.id
		ds_list_add(hit_enemies, _hit_id)
		with(other){
			audio_play_sound(hit_sound,0,0)
			damage_amount = _damage
			damage_type = other.damage_type
			event_user(0)
		}

		var _x = x
		var _y = y
		var _range = 200
		var splash_damage = damage * 1.5 * 0.75
		with (obj_enemy_parent) {
			if (hp > 0 && ds_list_find_index(other.hit_enemies, id) == -1
				&& point_distance(x, y, _x, _y) < _range && can_hit(other.target_type, target_type)) {
				ds_list_add(other.hit_enemies, id)
				damage_amount = splash_damage
				damage_type = other.damage_type
				event_user(0)
			}
		}

		var eff = instance_create_depth(x,y,depth,obj_takoyaki_bullet_effect)
		if instance_exists(eff){
			eff.image_xscale = 1.6
			eff.image_yscale = 1.6
		}
		instance_destroy()
	} else {
		with(other){
			audio_play_sound(hit_sound,0,0)
			damage_amount = other.damage
			damage_type = other.damage_type
			event_user(0)
		}
		instance_create_depth(x,y,depth,obj_takoyaki_bullet_effect)
		instance_destroy()
	}
}
