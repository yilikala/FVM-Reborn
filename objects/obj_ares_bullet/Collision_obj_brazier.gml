if ds_list_find_index(brazier_list,other.id) == -1 && burnt == 0 && row == other.grid_row{
	burnt += 1
	damage = round(damage * other.atk)
	ds_list_add(brazier_list,other.id)
	audio_play_sound(snd_bullet_burnt,0,0)
	if is_super {
		image_xscale = 2.2
		image_yscale = 2.2
	} else {
		image_xscale = 1.8
		image_yscale = 1.8
	}
}
