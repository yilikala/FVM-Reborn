// Inherit the parent event
instance_destroy(inner_inst)
if shape >= 1{
	var _x = x;
	var _y = y;
	var _range = 250
	var _has_virgo = (card_equipped_attire_id(plant_id) == "melon_virgo")
	if _has_virgo && shape == 2{
		_range = 350
	}
	bleed_damage = hp
	var _bleed = bleed_damage
	if _has_virgo && shape == 1{
		_bleed = round(bleed_damage * 1.3)
	}
	if _bleed > 0{
		with (obj_enemy_parent) {

			if (hp > 0 && point_distance(x, y, _x, _y) < _range && grid_row >= other.grid_row-1&&grid_row <= other.grid_row+1) {
				hp -= _bleed
				event_user(0)
			}
		}
	}
}

event_inherited();

