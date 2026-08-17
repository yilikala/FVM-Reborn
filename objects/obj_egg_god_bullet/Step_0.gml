if global.is_paused{
	exit
}
image_angle -= 5
x += move_speed
y -= cvspeed
cvspeed -= cgravity
if x > 2200 or y > 1200 or x < -200 or y < -200{
	instance_destroy()
}

// 弹跳后落地且未命中新敌人：落地溅射
if bounced && y >= thrower_y{
	egg_god_do_splash(damage, x, y, noone)
	instance_destroy()
}
// 未命中且目标死亡：落地溅射
if !bounced && target_enemy != noone && (!instance_exists(target_enemy) or target_enemy.hp <= 0){
	if y >= thrower_y{
		egg_god_do_splash(damage, x, y, noone)
		instance_destroy()
	}
}
