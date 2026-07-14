if !hit_enemy{
	if other.hp > 0 and row == other.grid_row and can_hit(target_type,other.target_type){
		with(other){
			audio_play_sound(snd_egg_bullet,0,0)
			damage_amount = other.damage
			if other.is_super{
				damage_amount = other.damage * 3
			}
			damage_type = other.damage_type
			event_user(0)
			if ice_timer < 600{
				ice_timer = 600
			}
	
		}
		var inst = instance_create_depth(x,y,depth,obj_thor_bullet_effect)
		if is_super{
			if shape==2 inst.sprite_index = spr_thor_bullet_s
			else inst.sprite_index = spr_thor_bullet_s_1
		}
		hit_enemy = true
		hitted_enemy = other.id
		instance_destroy()
	}
}
