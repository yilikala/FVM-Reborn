event_inherited();
plant_id = "hera";
obj_type = object_index;
current_level = 1
event_user(0)

if shape == 0{
	sprite_index = spr_hera_outer_1
	idle_anim = 10
}
else if shape == 1{
	sprite_index = spr_hera_1_outer_1
	idle_anim = 10
}
else if shape == 2{
	sprite_index = spr_hera_2_outer_1
	idle_anim = 9
}
else if shape == 3{
	sprite_index = spr_hera_3_outer_1
	idle_anim = 9
}

plant_type = "shield_outer"
is_slowdown = false
target_type = "normal"
attack_anim = 0
attack_timer = 0
flash_speed = 5
invincible = false
is_derivative = false
current_hp = hp
bleed_damage = 0

inner_inst = instance_create_depth(x, y-18, depth+2, obj_hera_inner)
inner_inst.parent_plant = id

if shape >= 2 && !is_derivative {
	var plant_list = ds_grid_get(global.grid_plants, grid_col, grid_row)
	if ds_exists(plant_list, ds_type_list) {
		for (var i = 0; i < ds_list_size(plant_list); i++) {
			var plant = ds_list_find_value(plant_list, i)
			if instance_exists(plant) && plant != id {
				plant.hp += 1000
				plant.max_hp += 1000
				event_user(2)
			}
		}
	}
}
