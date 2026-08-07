if global.is_paused{
	exit
}
if burnt == 1{
	if shape == 0 { sprite_index = spr_odin_bullet_f }
	else if shape == 1 { sprite_index = spr_odin_bullet_f_1 }
	else if shape == 2 { sprite_index = spr_odin_bullet_f_2 }
	else { sprite_index = spr_odin_bullet_f_3 }
}

x += move_speed

if x > 2200 or y > 1200 or x < 0 or y < 0{
	instance_destroy()
}
