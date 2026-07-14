function track_find_best_target(track_card){
	var _target_type = track_card.target_type
	var best_target = noone
	var min_x = room_width
	var max_hp = 0

	with(obj_enemy_parent){
		if hp > 0 && can_hit(_target_type, target_type) && y > 0 {
			if x < min_x || (x == min_x && hp > max_hp) {
				min_x = x
				max_hp = hp
				best_target = id
			}
		}
	}
	return best_target
}
