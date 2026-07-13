if global.is_paused{
	exit
}
event_inherited();
if is_frozen || state == CARD_STATE.SLEEP{
	exit
}
var current_flash_speed = flash_speed
if is_slowdown{
	current_flash_speed *= 2
}
// 检测自身右方的敌人，优先锁定地面目标；若无地面目标则锁定飞行目标
var has_enemy = false
var target_enemy = noone
var target_is_air = false
var min_distance = 10000

// 第一阶段：锁定可攻击的地面目标（target_type 为 throw 时可击中 normal / diver 等，排除 air）
with(obj_enemy_parent){
    if (grid_row == other.grid_row && grid_col >= other.grid_col && grid_col <= (global.grid_cols + 1) && target_type != "air" && can_target_on(other.target_type,target_type)){
        var distance = grid_col - other.grid_col
        if (distance < min_distance) {
            min_distance = distance
            target_enemy = id
            target_is_air = false
            has_enemy = true
        }
    }
}

// 第二阶段：没有地面目标时，锁定飞行目标（子弹将落在其下方地面以溅射伤害）
if (!has_enemy){
    with(obj_enemy_parent){
        if (grid_row == other.grid_row && grid_col >= other.grid_col && grid_col <= (global.grid_cols + 1) && target_type == "air"){
            var distance = grid_col - other.grid_col
            if (distance < min_distance) {
                min_distance = distance
                target_enemy = id
                target_is_air = true
                has_enemy = true
            }
        }
    }
}

// 存储目标敌人信息
if (has_enemy) {
    target_instance = target_enemy
    target_is_air_flag = target_is_air
} else {
    target_instance = noone
    target_is_air_flag = false
}
//攻击逻辑
if (has_enemy) {
    if (attack_timer <= cycle - attack_anim * current_flash_speed) {
        attack_timer++;
    }  else if (attack_timer == cycle - 30) {
        attack_count++
        event_user(1);
		attack_timer++;
    }else if (attack_timer <= cycle) {
        attack_timer++;
        state = CARD_STATE.ATTACK;
    }else {
        attack_timer = 0;
        state = CARD_STATE.IDLE;
    }
} else {
    attack_timer = 0;
    state = CARD_STATE.IDLE;
}