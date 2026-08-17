var _x = x;
	var _y = y;
	var _range = 220
	if shape == 2{
		_range = 350
	}
	if card_equipped_attire_id(plant_id) == "rotate_leo" && shape == 0{
		_range = 350
	}

	var _atk = atk
	if card_equipped_attire_id(plant_id) == "rotate_leo" && shape == 2{
		_atk = round(atk * 1.5)
	}

	with (obj_enemy_parent) {

		if (hp > 0 && point_distance(x, y, _x, _y) < _range && grid_row >= other.grid_row-other.range&&grid_row <= other.grid_row+other.range&&can_hit(other.target_type,target_type)) {

	            hp -= _atk;
				event_user(0)
	            audio_play_sound(snd_hit1,0,0)
	    }

	}