var target
if instance_exists(track_target) && track_target.hp > 0{
	target = track_target
}
else{
	target = track_find_best_target(id)
	track_target = target
}

	var inst = instance_create_depth(x, y-55, depth-500, obj_diana_bullet)
	inst.damage = atk
	inst.move_speed = 10
	inst.target_enemy = target
	inst.banding_card_obj = id
	inst.row = grid_row
	inst.is_super = false
	inst.shape = shape


	if shape == 0 { inst.sprite_index = spr_diana_bullet }
	else if shape == 1 { inst.sprite_index = spr_diana_bullet_1 }
	else if shape == 2 { inst.sprite_index = spr_diana_bullet_2 }
	else { inst.sprite_index = spr_diana_bullet_3 }


audio_play_sound(snd_throw,0,0)
