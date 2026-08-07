if global.is_paused{
	exit
}

// 动画计时器
if timer < flash_speed - 1 {
	timer++;
} else {
	switch (state) {
		case CARD_STATE.IDLE:
			if image_index < 7 image_index++;
			else image_index = 0;
		break;
            
		case CARD_STATE.ATTACK:
			if (image_index >= (7+1) && image_index <= (7+1) + attack_anim) image_index++;
			else image_index = (7+1);
		break;
		
	}
	timer = 0;
}

// 计算深度值
depth = parent_player.depth-2

//检测是否有敌人
var has_enemy = false
with(obj_enemy_parent){
	if (can_target_on("track",target_type) && hp > 0){
		has_enemy = true
		break
	}
}

// 攻击逻辑
if (has_enemy) {

    attack_timer++;

    // 进入攻击阶段
    if (attack_timer > cycle - attack_anim * flash_speed) {
        state = CARD_STATE.ATTACK;

        // 发射逻辑
        if (fire_count < bullet_count) {

            if (fire_cd <= 0) {
                event_user(1);   // 发射一发

                fire_count++;
                fire_cd = 4;     // 间隔5tick
            } else {
                fire_cd--;
            }

        }

    }

    // 一个周期结束
    if (attack_timer > cycle) {
        attack_timer = 0;
        state = CARD_STATE.IDLE;

        // 重置发射状态
        fire_count = 0;
        fire_cd = 0;
    }

} else {
    attack_timer = 0;
    state = CARD_STATE.IDLE;

    fire_count = 0;
    fire_cd = 0;
}