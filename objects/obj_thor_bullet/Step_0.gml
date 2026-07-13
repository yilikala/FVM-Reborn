if global.is_paused{
	exit
}
x += move_speed
y -= cvspeed
cvspeed -= cgravity
image_angle -= 5
if x > 2200 or y > 1200 or x < -200 or y < -200{
	instance_destroy()
}
// 飞行目标：子弹落到其下方地面时触发溅射（无需直接碰撞）
// 陆地目标阵亡：子弹落地时触发溅射
if (target_is_air || (target_enemy != noone && (!instance_exists(target_enemy) or target_enemy.hp <= 0))){
    if y >= thrower_y {
		var _inst = instance_create_depth(x,y,depth,obj_eggboilerpult_bullet_effect)
		if(is_super){
			if(shape==2)_inst.sprite_index = spr_thor_bullet_effect_s
			else _inst.sprite_index = spr_thor_bullet_effect_s_1
		}
		else{ _inst.sprite_index = spr_thor_bullet_effect
		}
    }
}