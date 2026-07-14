if global.is_paused{
	exit
}
timer++;

if timer mod 3 == 0 {
	if instance_exists(banding_card_obj){
		var _t = banding_card_obj.track_target
		if instance_exists(_t) && _t.hp > 0{
			target_enemy = _t
		}
		else{
			target_enemy = track_find_best_target(banding_card_obj)
			banding_card_obj.track_target = target_enemy
		}
	}
}

if instance_exists(target_enemy) && target_enemy.hp > 0 {
	var target_x = target_enemy.x;
	var target_y = target_enemy.y-75;

	var dir = point_direction(x, y, target_x, target_y);
	x += lengthdir_x(move_speed, dir);
	y += lengthdir_y(move_speed, dir);
} else {
	target_enemy = noone
	var dir = point_direction(xstart, ystart, x, y);
	x += lengthdir_x(move_speed, dir);
	y += lengthdir_y(move_speed, dir);
}

image_angle =- timer * 12

if x > 2200 or y > 1200 or x < -200 or y < -200{
	instance_destroy()
}
