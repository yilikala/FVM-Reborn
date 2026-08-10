if ds_list_find_index(hitted_enemy,other.id) == -1 && !disabled{
	if other.hp > 0 {
		// 直接伤害
		with(other){
			damage_amount = other.damage
			damage_type = other.damage_type
			ice_timer = other.ice_timer_frames
			is_slowdown = true
			event_user(0)
			audio_play_sound(hit_sound,0,0)
		}
		ds_list_add(hitted_enemy,other.id)

		// 3×3 溅射 + 减速
		if splash_ratio > 0{
			splash_row = other.grid_row
			splash_col = other.grid_col
			splash_dmg = round(damage * splash_ratio)
			with(obj_enemy_parent){
				if hp > 0 && ds_list_find_index(other.hitted_enemy, id) == -1
				&& grid_row >= other.splash_row - 1 && grid_row <= other.splash_row + 1
				&& grid_col >= other.splash_col - 1 && grid_col <= other.splash_col + 1{
					damage_amount = other.splash_dmg
					damage_type = other.damage_type
					ice_timer = other.ice_timer_frames
					is_slowdown = true
					event_user(0)
					audio_play_sound(hit_sound,0,0)
					ds_list_add(other.hitted_enemy, id)
				}
			}
		}
	}
}
