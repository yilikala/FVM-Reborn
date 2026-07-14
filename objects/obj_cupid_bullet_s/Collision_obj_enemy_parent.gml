

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
	}
}
