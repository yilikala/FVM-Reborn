
var effect_inst = instance_create_depth(x, y, depth, obj_aurora_dead_explode);
effect_inst.shape_dead = shape;
if (shape == 0) {
    effect_inst.sprite_index = spr_aurora_dead;
} else if (shape == 1) {
    effect_inst.sprite_index = spr_aurora_dead_1;
} else if (shape == 2) {
    effect_inst.sprite_index = spr_aurora_dead_2;
} else {
    effect_inst.sprite_index = spr_aurora_dead_3;
}
if shape==3 _r=2
if (shape >=1) {
    with (obj_enemy_parent) {
        if (grid_row >= other.grid_row - other._r && grid_row <= other.grid_row + other._r &&
            grid_col >= other.grid_col - other._r && grid_col <= other.grid_col + other._r) {
            var can_ash = !immune_to_ash;
            var _prev_hp = hp;
            hp -= 1800;
            event_user(0);
            if (can_ash) {
                if (_prev_hp > 0 && hp <= 0) {
                    if (special_ash) {
                        var inst = instance_create_depth(x, y - 20, depth, obj_mouse_ash_death);
                        inst.special_ash = true;
                        inst.sprite_index = sprite_index;
                        inst.image_index = image_index;
                    } else {
                        instance_create_depth(x, y - 20, depth, obj_mouse_ash_death);
                    }                
                    instance_destroy();
                }
            }
        }
    }
	audio_play_sound(snd_coke_bomb_explode, 0, false);
}