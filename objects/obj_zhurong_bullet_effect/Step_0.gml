if global.is_paused {
    exit;
}

timer++;

// ===== 动画控制：每5tick一帧 =====
var total_frames = sprite_get_number(sprite_index);
var total_time = total_frames * 5

// 每次伤害的间隔（自动算）
var damage_interval = total_time / 10;

image_index = floor(timer / 5);

// 防止越界（保险）
if image_index >= total_frames {
    image_index = total_frames - 1;
}

// ===== 范围伤害：每10tick一次，总共10次 =====
if floor((timer - 1) / damage_interval) != floor(timer / damage_interval) {
    event_user(0);
}

// ===== 生命周期 =====
if (timer >= total_time) {
    instance_destroy();
}