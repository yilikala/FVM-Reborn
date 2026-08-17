event_inherited();

plant_id = "brahma"; 
obj_type = object_index;
current_level = 1

event_user(0)

sprite_index = spr_brahma;
if shape == 1 {sprite_index = spr_brahma_1;}
else if shape == 2 {sprite_index = spr_brahma_2;}
else if shape == 3 {sprite_index = spr_brahma_3;}

// ========== 特定属性默认值 ==========

attack_anim = 0
idle_anim = 32
flash_speed = 5
plant_type = "coffee"
is_slowdown = false

current_hp = hp

can_mouse_list = ["can_mouse"]
exploded = false
is_derivative = false


var total_frames = sprite_get_number(sprite_index);
transform_timer = total_frames * flash_speed

// 记录上一张放置的卡片id，用于复制
target_card = global.prev_place_id
