// obj_small_furnace 的 Create 事件
//plant_id = "small_fire";  // 唯一标识符
event_inherited();  // 继承父对象属性
plant_id = "zhurong"; 
// 设置对象类型和精灵
obj_type = object_index;
current_level = 1
event_user(0)
if shape == 0{
	sprite_index = spr_zhurong
}
else if shape == 1{
	sprite_index = spr_zhurong_1
}
else if shape == 2{
	sprite_index = spr_zhurong_2
}
else if shape == 3{
	sprite_index = spr_zhurong_3
}

// ========== 特定属性默认值 ==========

attack_anim = 12;
idle_anim = 9
flash_speed = 5
plant_type = "normal"
is_slowdown = false
target_type = "throw"

target_instance = noone
cooldown_timer = cycle
attacking = false