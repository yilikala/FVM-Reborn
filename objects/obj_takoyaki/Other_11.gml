var target
if instance_exists(track_target) && track_target.hp > 0{
	target = track_target
}
else{
	target = track_find_best_target(id)
	track_target = target
}

var inst = instance_create_depth(x,y-55,depth-500,obj_takoyaki_bullet)
inst.damage = atk
inst.move_speed = 10
inst.target_enemy = target
inst.banding_card_obj = id
inst.row = grid_row
if card_equipped_attire_id(plant_id) == "takoyaki_cancer"{
	inst.sprite_index = spr_takoyaki_cancer_bullet
	if shape >= 2{
		inst.sprite_index = spr_takoyaki_cancer_bullet_1
	}
}

if shape == 2{
	var inst2 = instance_create_depth(x+40,y-55,depth-500,obj_takoyaki_bullet)
	inst2.damage = atk
	inst2.move_speed = 10
	inst2.target_enemy = target
	inst2.timer = -15
	inst2.banding_card_obj = id
	inst2.row = grid_row
	if card_equipped_attire_id(plant_id) == "takoyaki_cancer"{
		inst2.sprite_index = spr_takoyaki_cancer_bullet
		if shape >= 2{
			inst2.sprite_index = spr_takoyaki_cancer_bullet_1
		}
	}
}

audio_play_sound(snd_throw,0,0)
