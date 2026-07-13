// 用户事件1 - 发射子弹
audio_play_sound(snd_throw, 0, 0)

// 计算普通子弹数量：shape 0 投掷两发，shape>=1 投掷三发
var normal_count = (shape == 0) ? 2 : 3

// 判断是否需要额外投掷超级子弹
var fire_super = false
if (shape >= 3){
    fire_super = true
}
else if (shape == 2 && attack_count mod 3 == 0 && attack_count > 0){
    fire_super = true
}

var _ox = x - 40
var _oy = y - 125

// 待发射子弹列表（依次发射：超级子弹优先作为第一发）
var _bullets = []

if (fire_super){
    var _inst = instance_create_depth(_ox, _oy, depth - 500, obj_thor_bullet)
	if(shape==2)_inst.sprite_index = spr_thor_bullet_s
	else _inst.sprite_index = spr_thor_bullet_s_1
    _inst.is_super = true
    _inst.splash_ratio = 0.5
    _inst.damage = atk * 3
    _bullets[0] = _inst
}

for (var i = 0; i < normal_count; i++){
    var _offset = (i + (fire_super ? 1 : 0)) * 20
    var _inst = instance_create_depth(_ox - _offset, _oy, depth - 500, obj_thor_bullet)
	switch (shape) 
	{
		case 0:
		sprite_index = spr_thor_bullet
        break;

		case 1:
		sprite_index = spr_thor_bullet_1
        break;
		
		case 2:
		sprite_index = spr_thor_bullet_2
        break;

		default:sprite_index = spr_thor_bullet_3
        break;
	}
    _inst.is_super = false
    _inst.splash_ratio = 0.4
    _inst.damage = atk
    _bullets[array_length(_bullets)] = _inst
}

// 为每发子弹设置抛物线轨迹与目标信息
for (var k = 0; k < array_length(_bullets); k++){
    var inst = _bullets[k]

    inst.original_damage = inst.damage
    inst.row = grid_row
    inst.thrower_y = y
    inst.target_is_air = target_is_air_flag

    // 如果有目标敌人，计算预测落点
    if (target_instance != noone && instance_exists(target_instance)) {
        var enemy_x = target_instance.x
        var enemy_speed = target_instance.move_speed

        var distance_x = enemy_x - inst.x
        var flight_time = clamp(30 + (distance_x/1000) * 45, 30, 75)

        var predicted_x = enemy_x - enemy_speed * flight_time - 50
        if (predicted_x < x) predicted_x = x

        var total_distance_x = predicted_x - inst.x
        var total_distance_y = 600

        if (target_is_air_flag){
            // 飞行目标：使子弹的落点（地面）正好位于飞行目标的预测位置下方
            // 使用 total_distance_y=600 的抛物线，落点在 t=u*flight_time 时 y=thrower_y，
            // 落点 x = inst.x + total_distance_x * u。修正 total_distance_x 使落点对齐飞行目标。
            var _u = (1 + sqrt(1 + 500/total_distance_y)) / 2
            var _flyer_x = enemy_x - enemy_speed * flight_time
            total_distance_x = (_flyer_x - inst.x) / _u
            total_distance_y = 600
        }

        inst.move_speed = total_distance_x / flight_time
        inst.cgravity = (2 * total_distance_y) / (flight_time * flight_time)
        inst.cvspeed = (total_distance_y - 0 * inst.cgravity * flight_time * flight_time) / flight_time

        inst.target_enemy = target_instance
        inst.has_target = true
    } else {
        inst.move_speed = 8
        inst.cvspeed = 6
        inst.cgravity = 0.2
        inst.has_target = false
        inst.target_enemy = noone
    }

    inst.hit_enemy = false
    inst.splashed = false
    inst.shape = shape
}