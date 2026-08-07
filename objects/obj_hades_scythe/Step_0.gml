if global.is_paused{
	exit
}

var pos = get_world_position_from_grid(grid_row, grid_col)
x = pos.x
y = pos.y

if timer < flash_speed - 1 {
    timer++;
} else {

    switch (state) {

        case CARD_STATE.IDLE:
            if image_index < idle_anim - 1 {
                image_index++;
            } else {
                image_index = 0;
            }
        break;

        case CARD_STATE.ATTACK:
            var attack_start = idle_anim;
            var attack_end = idle_anim + attack_anim - 1;

            if image_index < attack_start || image_index > attack_end {
                image_index = attack_start;
            } else if image_index < attack_end {
                image_index++;
            } else {
                image_index = attack_start; // 循环
            }
        break;

    }

    timer = 0;
}

depth = -500

// 冷却推进
if (cooldown > 0) {
    cooldown--;
}

// 冷却完成且未攻击时索敌
if (!is_attacking && cooldown <= 0) {

    var target_enemy = noone;
    var min_distance = 10000;
    var enemy_x_temp = undefined;

    with(obj_enemy_parent) {
          target_enemy = id;
          enemy_x_temp = x;   // 提前获取敌人X坐标
            
    }

    // 仅在获取到有效敌人位置时开始攻击
    if (target_enemy != noone && enemy_x_temp != undefined) {
        is_attacking = true;
        attack_timer = 0;  // 攻击计时器重置
    }
}

// 攻击推进
if (is_attacking) {
    state = CARD_STATE.ATTACK;
    attack_timer++;

    var t = attack_timer
    var start_t = 32;
	var interval = 10;

	for (var i = 0; i < bullet_amount; i++) {
		 if (t == start_t + i * interval) {
		     event_user(1);
		 }
	}

    // 攻击完成
    if (attack_timer >= attack_anim * flash_speed) {
        is_attacking = false;
        attack_timer = 0;
        cooldown = cycle;  // 重置攻击冷却
    }
} else {
    state = CARD_STATE.IDLE;
}
