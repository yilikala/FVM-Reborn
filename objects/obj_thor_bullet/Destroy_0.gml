var _x = x
var _y = y
if instance_exists(hitted_enemy){
	_x = hitted_enemy.x;
	_y = hitted_enemy.y;
}
var _range = 200;

with (obj_enemy_parent) {
    if (hp > 0 && point_distance(x, y, _x, _y) < _range && grid_row <= other.row+1&& grid_row >= other.row-1 && id != other.hitted_enemy  && (can_hit(other.target_type,target_type) or target_type == "air")) {
        // 对敌人造成溅射伤害（溅射倍率由 splash_ratio 决定：普通 40%，超级 50%；飞行单位同样受溅射）
        damage_amount = other.damage * other.splash_ratio
		damage_type = other.damage_type
		event_user(0)
		// 施加减速效果（600帧）
		if (other.slow_duration > 0){
			if (ice_timer < other.slow_duration){
				ice_timer = other.slow_duration
			}
		}
    }
}
audio_play_sound(snd_egg_bullet,0,0)