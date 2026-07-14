var _x = x
var _y = y
var _row = grid_row
var _hw = global.grid_cell_size_x * 1.8

with (obj_enemy_parent) {
	if (hp > 0 && abs(grid_row - _row) <= 1 && abs(x - _x) <= _hw) {
		hp -= other.bleed_damage
		event_user(0)
	}
}
