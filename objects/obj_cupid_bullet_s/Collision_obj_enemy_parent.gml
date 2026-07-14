

if other.hp > 0 and row == other.grid_row  and can_hit(target_type,other.target_type){
	if ds_list_find_index(hit_enemy_list, other.id) == -1 {
		ds_list_add(hit_enemy_list, other.id)
		with(other){
			if other.burnt == 1{
				audio_play_sound(snd_fire_hit,0,0)
			}
			else{
				audio_play_sound(hit_sound,0,0)
			}
			damage_amount = other.damage * 3
			damage_type = other.damage_type
			event_user(0)

		}
		if loki_burnt {
			var _hit_id = other.id
			var _hit_row = other.grid_row
			var _hit_x = other.x
			var _sdmg = damage
			if loki_shape >= 2 {
				var _r1 = 0.6
				if loki_shape >= 3 { _r1 = 1.0 }
				with(obj_enemy_parent){
					if hp > 0 && id != _hit_id && grid_row == _hit_row && abs(x - _hit_x) <= global.grid_cell_size_x * 0.8 {
						hp -= _sdmg * _r1
						event_user(0)
					}
				}
			}
			if loki_shape >= 3 {
				with(obj_enemy_parent){
					if hp > 0 && id != _hit_id && abs(grid_row - _hit_row) <= 1 && abs(x - _hit_x) <= global.grid_cell_size_x * 1.8 {
						hp -= _sdmg * 0.4
						event_user(0)
					}
				}
			}
		}
	}
}
