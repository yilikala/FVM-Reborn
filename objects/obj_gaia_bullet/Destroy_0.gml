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
			    //// 是否属于“可触发灰烬”的类型
			    //var can_ash = !immune_to_ash;

			    //// 记录伤害前血量
			    //var _prev_hp = hp;

			    //// 一律先扣血（取消秒杀）
			    //hp -= other.damage;
				//if other.shape_bullet != 0{stun_timer = 120;}

			    //// 受伤表现（保留你原来的）
			    //event_user(0);

			    //// 只有“允许灰烬”的单位才可能触发
			    //if (can_ash)
			    //{
			    //    // 且必须是“这一下打死的”
			    //    if (_prev_hp > 0 && hp <= 0)
			    //    {
			    //        if (special_ash)
			    //        {
			    //            var inst = instance_create_depth(x, y-20, depth, obj_mouse_ash_death);
			    //            inst.special_ash = true;
			    //            inst.sprite_index = sprite_index;
			    //            inst.image_index = image_index;
			    //        }
			    //        else
			    //        {
			    //            instance_create_depth(x, y-20, depth, obj_mouse_ash_death);
			    //        }

			    //        // 这里不要直接 destroy，交给死亡流程（更安全）
			    //        // 如果你当前工程必须手动销毁，再打开下面这行：
			    //        instance_destroy();
			    //    }
			    //}
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