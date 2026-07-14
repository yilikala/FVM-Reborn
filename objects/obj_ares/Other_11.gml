b_count++

var total_bursts = 4
if shape >= 1 { total_bursts = 5 }
if shape >= 2 { total_bursts = 6 }

var front_limit = total_bursts
if shape == 2 { front_limit = 5 }

if b_count <= front_limit {
	var inst = instance_create_depth(x+40, y-75, depth-500, obj_ares_bullet)
	inst.damage = atk
	inst.move_speed = 8
	inst.row = grid_row
	inst.super_mult = 1
	if shape >= 3 && b_count == 1 {
		inst.is_super = true
		inst.super_mult = 10
		inst.sprite_index = spr_ares_bulllet_s
	}
}

var inst2 = instance_create_depth(x-40, y-75, depth-500, obj_ares_bullet)
inst2.damage = atk
inst2.move_speed = -8
inst2.row = grid_row
inst2.image_angle = 180
inst2.super_mult = 1
if shape == 2 && b_count == 1 {
	inst2.is_super = true
	inst2.super_mult = 6
	inst2.sprite_index = spr_ares_bulllet_s
}
if shape >= 3 && b_count == 1 {
	inst2.is_super = true
	inst2.super_mult = 10
	inst2.sprite_index = spr_ares_bulllet_s
}

audio_play_sound(snd_shot, 0, 0);
