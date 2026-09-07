	var _x = x;
	
	// 根据 shape 决定行偏移量：默认 1（3x3），shape >= 3 时为 2（5x5）
	var _range = (shape_bullet >= 3) ? 275 : 165
	var row_offset = (shape_bullet >= 3) ? 2 : 1;

	with (obj_enemy_parent) {
		
		if (abs(x - _x) < _range 
		&& grid_row >= other.row - row_offset 
		&& grid_row <= other.row + row_offset) {
			if array_get_index(other.can_mouse_list, mouse_id) != -1 && !can_dropped
			{
			    into_act();
			}
			else
			{
				if (immune_to_ash && hp>other.damage) {
		            // 对免疫灰烬的敌人只造成伤害
		            hp -= other.damage;
					event_user(0)
		        } else {
		            // 直接摧毁非免疫敌人
					if special_ash{
						var inst = instance_create_depth(x,y-20,depth,obj_mouse_ash_death)
						inst.special_ash = true
						inst.sprite_index = sprite_index
						inst.image_index = image_index
					}
					else{
						instance_create_depth(x,y-20,depth,obj_mouse_ash_death)
					}
		            instance_destroy();
		        }
			}
		}
	}
audio_play_sound(snd_gaia_explode,0,0)