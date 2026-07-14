event_inherited();
plant_id = "diana";
obj_type = object_index;
current_level = 1
event_user(0)
base_atk = atk
if shape == 0{
	sprite_index = spr_diana
}
else if shape == 1{
	sprite_index = spr_diana_1
}
else if shape == 2{
	sprite_index = spr_diana_2
}
else if shape == 3{
	sprite_index = spr_diana_3
}

attack_anim = 10;
idle_anim = 8
flash_speed = 5
plant_type = "normal"
is_slowdown = false
target_type = "track"

track_target = noone
track_timer = 0
