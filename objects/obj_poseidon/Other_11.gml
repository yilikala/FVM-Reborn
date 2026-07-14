var _x = x;
var _y = y;
var _row = grid_row
var _hw = global.grid_cell_size_x * 2.5
var _hr = 2
if shape == 3 { _hr = 3 }

with (obj_enemy_parent) {
	if (hp > 0 && abs(grid_row - _row) <= _hr && abs(x - _x) <= _hw && can_hit(other.target_type, target_type)) {
		hp -= other.atk;
		event_user(0)
		if ice_timer < 600{
			ice_timer = 600
		}
		audio_play_sound(snd_hit1, 0, 0)
	}
}
