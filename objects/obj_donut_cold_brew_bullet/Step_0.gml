if global.is_paused{
	image_speed = 0
	exit
}
image_speed = 1
y += fall_speed

if !instance_exists(target_enemy) || target_enemy.hp <= 0 {
	var _ground_y = global.grid_offset_y + global.grid_cell_size_y * pred_row + 30
	if y >= _ground_y {
		var eff = instance_create_depth(x, y, depth, obj_donut_cold_brew_bullet_effect)
		if instance_exists(eff){ eff.sprite_index = spr_donut_bullet_effect }
		instance_destroy()
		exit
	}
}

if y > 1200 {
	instance_destroy()
}
