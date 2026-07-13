// obj_thor 的 Create 事件
event_inherited();  // 继承父对象属性
plant_id = "thor";
// 设置对象类型和精灵
obj_type = object_index;
current_level = 1
event_user(0)
if shape == 0{
	sprite_index = spr_thor
}
else if shape == 1{
	sprite_index = spr_thor_1
}
else if shape == 2{
	sprite_index = spr_thor_2
}
else if shape == 3{
	sprite_index = spr_thor_3
}

// ========== 特定属性默认值 ==========

attack_anim = 13;
idle_anim = 13
flash_speed = 5
plant_type = "normal"
is_slowdown = false
target_instance = noone
target_type = "throw"
attack_count = 0  // 攻击轮次计数，用于超级子弹触发判断
target_is_air_flag = false  // 当前目标是否为飞行单位