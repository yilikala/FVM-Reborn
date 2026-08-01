var _x = x
var _hit_row = row
if instance_exists(hitted_enemy){
	_x = hitted_enemy.x;
	_hit_row = hitted_enemy.grid_row;
}
var splash_ratio = 0.4
if shape >= 1{
	splash_ratio = 0.5
}

with (obj_enemy_parent) {
	if (hp > 0 && id != other.hitted_enemy && abs(grid_row - _hit_row) <= 1 && abs(x - _x) <= global.grid_cell_size_x * 1.8 && (can_hit(other.target_type,target_type) or target_type == "air")) {
		damage_amount = other.damage * splash_ratio
		if other.is_super{
			damage_amount = other.damage * 3 * splash_ratio
		}
		damage_type = other.damage_type
		event_user(0)
		if ice_timer < 600{
			ice_timer = 600
		}
	}
}
audio_play_sound(snd_egg_bullet,0,0)
