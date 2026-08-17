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
//检测自身右方是否有敌人
var has_enemy = false
with(obj_enemy_parent){
	if (grid_row == other.grid_row && grid_col <= (global.grid_cols + 1)) && can_target_on(other.target_type,target_type){
		has_enemy = true
		break
	}
}
//攻击逻辑
if (has_enemy) {
    if (attack_timer <= cycle - attack_anim * current_flash_speed) {
        attack_timer++;
    } else if (attack_timer <= cycle) {
        attack_timer++;
        state = CARD_STATE.ATTACK;
    } else {
        attack_timer = 0;
        state = CARD_STATE.IDLE;
		b_count = 0
    }
	var _has_attire = (card_equipped_attire_id(plant_id) != -1)
	if _has_attire {
		//时装装备时：shape0前后各3发，shape1前后各3发(攻击力+20%)，shape2前后各4发
		if (attack_timer == cycle - 8*flash_speed) && shape == 2{
			event_user(1);
		}
		if (attack_timer == cycle - 6*flash_speed){
			event_user(1);
		}
		if (attack_timer == cycle - 4*flash_speed){
			event_user(1)
		}
		if (attack_timer == cycle - 2*flash_speed){
			event_user(1);
		}
	}
	else {
		//无时装时：保持原始攻击模式
		if (attack_timer == cycle - 7*flash_speed){
			event_user(1);
		}
		if (attack_timer == cycle - 4*flash_speed){
			event_user(1)
		}
		if (attack_timer == cycle - 1*flash_speed) && shape >= 2{
			event_user(1);
		}
	}
} else {
    // 没有符合条件的敌人，重置状态
    attack_timer = 0;
    state = CARD_STATE.IDLE;
}


