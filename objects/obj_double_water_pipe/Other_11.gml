b_count++

var _attire_id = card_equipped_attire_id(plant_id)
var _has_attire = (_attire_id != -1)
var _atk = atk
var _fire_forward = true

if _has_attire {
	//时装装备时：shape1攻击力提升20%
	if shape >= 1{
		_atk = round(atk * 1.2)
	}
}
else {
	//无时装时：仅在第一次发射或shape>=1时发射正向子弹
	_fire_forward = (b_count == 1 || (b_count >= 2 && shape >= 1))
}

if _fire_forward {
	var inst = instance_create_depth(x+40,y-75,depth-500,obj_waterpipe_bullet)
	inst.damage = _atk
	inst.move_speed = 8
	inst.row = grid_row
	if _attire_id == "water_pipe_libra"{
		inst.sprite_index = spr_water_pipe_libra_bullet
	}
}

var inst2 = instance_create_depth(x-40,y-75,depth-500,obj_waterpipe_bullet)
inst2.damage = _atk
inst2.move_speed = -8
inst2.row = grid_row
inst2.image_angle = 180
if _attire_id == "water_pipe_libra"{
	inst2.sprite_index = spr_water_pipe_libra_bullet
}

audio_play_sound(snd_shot, 0, 0);