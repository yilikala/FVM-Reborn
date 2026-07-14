var _x = x;
var _y = y;
var _hw = global.grid_cell_size_x * 2.5
var _hh = global.grid_cell_size_y * 2.5
if shape == 3 { _hw = global.grid_cell_size_x * 3.5 }

with (obj_enemy_parent) {
	if (hp > 0 && abs(x - _x) <= _hw && abs(y - _y) <= _hh && can_hit(other.target_type, target_type)) {
		hp -= other.atk;
		event_user(0)
		if ice_timer < 600{
			ice_timer = 600
		}		
		audio_play_sound(snd_hit1, 0, 0)
	}
}
