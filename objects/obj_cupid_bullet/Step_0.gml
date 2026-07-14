if global.is_paused {
	exit;
}
if burnt == 1{
	sprite_index = spr_cupid_bulllet_f
}
timer++;
image_index = (floor(timer / 3)) mod 4;

x += move_speed;

if variable_instance_exists(id, "target_row"){
	var target_y =global.grid_offset_y + global.grid_cell_size_y*target_row;

	var transition_speed = 0.15;
	y = lerp(y, target_y, transition_speed);

	if abs(y - target_y) < 30 {
		row = target_row
	}
}

if x > 2200 or y > 1200 or x < 0 or y < 0 {
	instance_destroy();
}
