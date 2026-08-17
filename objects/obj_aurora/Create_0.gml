event_inherited();  // 继承父对象属性
plant_id = "aurora"; 

event_user(0)
sprite_index = spr_aurora;
if shape == 1{
	sprite_index = spr_aurora_1
}
else if shape == 2{
	sprite_index = spr_aurora_2
}
else if shape == 3{
	sprite_index = spr_aurora_3
}

// ========== 特定属性默认值 ==========

attack_anim = 0;
idle_anim = 12
flash_speed = 5
plant_type = "normal"
_r = 1
is_slowdown = false

atk_whitelist = ["thor","egg_god","chocolate_pult","ice_egg_boiler_pult","egg_boiler_pult","pan_fried_bun","salad_pult","stinky_tofu_pult"]

ds_list_add(global.buff_sources, id)
global.buff_dirty = true
