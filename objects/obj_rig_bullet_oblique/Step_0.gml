if global.is_paused{
	exit
}

// 命中动画优先
if (bullet_hit) {
	hit_anim_timer++;

	// 每5tick一帧：4 → 5 → 6
	image_index = 4 + floor(hit_anim_timer / 5);

	// 播放完 4,5,6（共3帧 → 15tick）
	if (hit_anim_timer >= 15) {
		bullet_hit = false;
		hit_anim_timer = 0;
		anim_timer = 0; // 防止切回时跳帧
	}
}
else {
	// 普通动画 0~3 循环
	if (anim_timer < 19) {
		anim_timer++;
	} else {
		anim_timer = 0;
	}

	image_index = floor(anim_timer / 5);
}


x += move_speed_x;
y += move_speed_y;

if x > 2200 or y > 1200 or x < 0 or y < 0{
	instance_destroy()
}