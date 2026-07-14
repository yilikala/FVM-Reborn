if global.is_paused{
	exit
}
x += move_speed
y -= cvspeed
cvspeed -= cgravity
image_angle -= 5
if x > 2200 or y > 1200 or x < -200 or y < -200{
	instance_destroy()
	exit
}
if y >= thrower_y {
	var inst = instance_create_depth(x,y,depth,obj_thor_bullet_effect)
	if is_super{
	if shape==2 inst.sprite_index = spr_thor_bullet_s
	else inst.sprite_index = spr_thor_bullet_s_1
	}
	instance_destroy()
	exit
}

