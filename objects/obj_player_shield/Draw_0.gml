draw_self()

// 动画帧（用盾牌自身的 timer 驱动，暂停时 timer 不变→动画冻结）
var _frame = floor(timer / 6)

// gods_shield 宝石特效（固定在出生点，不跟随浮动）
if is_gods_shield{
	if gods_flame_gem{ draw_sprite_ext(spr_gods_shield_effect_1, _frame % sprite_get_number(spr_gods_shield_effect_1), spawn_x-15, spawn_y-45, 1.8, 1.8, 0, c_white, 1) }
	if gods_damage_gem{ draw_sprite_ext(spr_gods_shield_effect_2, _frame % sprite_get_number(spr_gods_shield_effect_2), spawn_x-15, spawn_y-12, 1.8, 1.8, 0, c_white, 1) }
	if gods_buff_gem{ draw_sprite_ext(spr_gods_shield_effect_3, _frame % sprite_get_number(spr_gods_shield_effect_3), spawn_x-15, spawn_y-12, 1.8, 1.8, 0, c_white, 1) }
	if gods_hp_gem{ draw_sprite_ext(spr_gods_shield_effect_4, _frame % sprite_get_number(spr_gods_shield_effect_4), spawn_x-15, spawn_y-12, 1.8, 1.8, 0, c_white, 1) }
}
else if is_master_shield{
	if gods_flame_gem{ draw_sprite_ext(spr_master_shield_effect_1, _frame % sprite_get_number(spr_master_shield_effect_1), spawn_x-15, spawn_y-45, 1.8, 1.8, 0, c_white, 1) }
	if gods_damage_gem{ draw_sprite_ext(spr_master_shield_effect_2, _frame % sprite_get_number(spr_master_shield_effect_2), spawn_x-15, spawn_y-12, 1.8, 1.8, 0, c_white, 1) }
	if gods_buff_gem{ draw_sprite_ext(spr_master_shield_effect_3, _frame % sprite_get_number(spr_master_shield_effect_3), spawn_x-15, spawn_y-12, 1.8, 1.8, 0, c_white, 1) }
	if master_eye_gem{ draw_sprite_ext(spr_master_shield_effect_4, _frame % sprite_get_number(spr_master_shield_effect_4), spawn_x-15, spawn_y-12, 1.8, 1.8, 0, c_white, 1) }
}
