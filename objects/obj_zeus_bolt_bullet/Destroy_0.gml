var _x = x
var _y = y
if instance_exists(target_enemy){
	_x = target_enemy.x;
	_y = target_enemy.y;
}

var _range = 200;

with (obj_enemy_parent) {
	if (hp > 0 && point_distance(x, y, _x, _y) < _range 
		&& grid_row <= other.target_enemy.grid_row + 1 
		&& grid_row >= other.target_enemy.grid_row - 1 
		&& id != other.target_enemy 
		&& can_hit(other.target_type,target_type)){
	        
	    // 对敌人造成溅射伤害
	    damage_amount = other.damage * other.splash_ratio
		damage_type = other.damage_type
		event_user(0)
	        
	}
}