var target
if instance_exists(track_target) && track_target.hp > 0{
	target = track_target
}
else{
	target = track_find_best_target(id)
	track_target = target
}

var _attire_id = card_equipped_attire_id(plant_id)
var _has_attire = (_attire_id != -1)
var _atk = atk

// 巨蟹座精灵：shape>1攻击力增加20%
if _has_attire && shape > 1{
	_atk = round(atk * 1.2)
}

// 决定本次event_user(1)发射几发子弹
// 原始：1发（shape0/1），2发（shape2）
// 巨蟹座：2发（shape1），3发（shape2）
var _shots = 1
if shape == 2{
	_shots = 2
}
if _has_attire{
	if shape == 1{
		_shots = 2
	}
	else if shape == 2{
		_shots = 3
	}
}

for (var _i = 0; _i < _shots; _i++){
	var inst = instance_create_depth(x + _i*40, y-55, depth-500, obj_takoyaki_bullet)
	inst.damage = _atk
	inst.move_speed = 10
	inst.target_enemy = target
	inst.timer = -15*_i
	inst.banding_card_obj = id
	inst.row = grid_row
	if _attire_id == "takoyaki_cancer"{
		inst.sprite_index = spr_takoyaki_cancer_bullet
		if shape >= 2{
			inst.sprite_index = spr_takoyaki_cancer_bullet_1
		}
	}
}

audio_play_sound(snd_throw,0,0)
