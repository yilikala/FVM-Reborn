
if !hit && other.hp > 0 && pred_row == other.grid_row && can_hit(target_type, other.target_type){
	hit = true
	var _x = x
	var _y = y
	var _hit_row = other.grid_row
	var _hit_id = other.id
	var _dmg = damage

	with(other){
		audio_play_sound(hit_sound, 0, 0)
		damage_amount = _dmg
		damage_type = other.damage_type
		event_user(0)
	}

	var _splash = _dmg * 0.25
	with(obj_enemy_parent){
		if hp > 0 && id != _hit_id && abs(grid_row - _hit_row) <= 1 && abs(x - _x) <= global.grid_cell_size_x * 1.8 {
			damage_amount = _splash
			damage_type = other.damage_type
			event_user(0)
		}
	}

	var eff = instance_create_depth(_x, _y, depth, obj_donut_cold_brew_bullet_effect)
	if instance_exists(eff){ eff.sprite_index = spr_donut_bullet_effect }
	instance_destroy()
}
