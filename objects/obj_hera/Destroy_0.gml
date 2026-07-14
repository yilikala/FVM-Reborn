if instance_exists(inner_inst){
	instance_destroy(inner_inst)
}

var _x = x
var _y = y
var _row = grid_row

var _hw3 = global.grid_cell_size_x * 1.8
with (obj_enemy_parent) {
	if (hp > 0 && abs(grid_row - _row) <= 1 && abs(x - _x) <= _hw3) {
		hp -= other.hp
		event_user(0)
	}
}

var _hw5 = global.grid_cell_size_x * 2.8
with (obj_enemy_parent) {
	if (hp > 0 && abs(grid_row - _row) <= 2 && abs(x - _x) <= _hw5) {
		if immune_to_ash && hp > other.atk {
			hp -= other.atk
			event_user(0)
		} else {
			if special_ash{
				var inst = instance_create_depth(x, y-20, depth, obj_mouse_ash_death)
				inst.special_ash = true
				inst.sprite_index = sprite_index
				inst.image_index = image_index
			} else {
				instance_create_depth(x, y-20, depth, obj_mouse_ash_death)
			}
			instance_destroy()
		}
	}
}

instance_create_depth(x, y, depth-1, obj_hera_explode)
audio_play_sound(snd_coke_bomb_explode, 0, 0)
