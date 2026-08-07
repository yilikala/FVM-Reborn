if ds_list_find_index(brazier_list, other.id) == -1 && burnt == 0 && row == other.grid_row{
	burnt += 1
	damage = round(damage * other.atk)
	ds_list_add(brazier_list, other.id)
	audio_play_sound(snd_bullet_burnt, 0, 0)
	image_xscale = 2.2
	image_yscale = 2.2
	if shape == 0 { sprite_index = spr_odin_bullet_f }
	else if shape == 1 { sprite_index = spr_odin_bullet_f_1 }
	else if shape == 2 { sprite_index = spr_odin_bullet_f_2 }
	else { sprite_index = spr_odin_bullet_f_3 }
}
