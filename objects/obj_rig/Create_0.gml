event_inherited();  // 继承父对象属性

plant_id = "rig"; 
obj_type = object_index;
current_level = 1

event_user(0)

if shape == 1 {sprite_index = spr_rig_1;}
else if shape == 2 {sprite_index = spr_rig_2;}
else if shape == 3 {sprite_index = spr_rig_3;}
else {sprite_index = spr_rig;}

// ========== 特定属性默认值 ==========

attack_anim = 16;
idle_anim = 9
flash_speed = 5
plant_type = "normal"
is_slowdown = false
target_type = "pierce"

cooldown_timer = cycle
attacking = false

global.rig_count += 1

