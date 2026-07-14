if instance_exists(parent_plant){
	var flash_alpha = parent_plant.flash_value / 150
	var slowdown_tint = c_white
	if parent_plant.is_slowdown{
		slowdown_tint = c_lime
	}

	if flash_alpha > 0{
		draw_sprite_ext(sprite_index, image_index, x, y-18, image_xscale, image_yscale, 0, c_red, flash_alpha)
		draw_sprite_ext(sprite_index, image_index, x, y-18, image_xscale, image_yscale, 0, c_white, 1-flash_alpha)
	}
	else{
		draw_sprite_ext(sprite_index, image_index, x, y-18, image_xscale, image_yscale, 0, slowdown_tint, 1)
	}
}
