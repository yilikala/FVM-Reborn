/// @function egg_god_do_splash(_dmg, _x, _y, _exclude_id)
/// @desc 3×3 溅射伤害 + 毒雾 + 定身 + 溅射动画
function egg_god_do_splash(_dmg, _x, _y, _exclude_id){
    var _grid = get_grid_position_from_world(_x, _y)
    var _splash = round(_dmg * 0.5)

    // 3×3 溅射伤害（50%）+ 25% 定身
    with(obj_enemy_parent){
        if hp > 0 && id != _exclude_id
        && grid_row >= _grid.row - 1 && grid_row <= _grid.row + 1
        && grid_col >= _grid.col - 1 && grid_col <= _grid.col + 1{
            damage_amount = _splash
            damage_type = "throw"
            event_user(0)
            if irandom_range(1, 100) <= 25{
                stun_timer = 420
                is_stun = true
            }
        }
    }

    // 毒雾：每秒 50% 伤害，持续 3 秒
    var _poison = instance_create_depth(_x, _y, depth, obj_stinkytofupult_bullet_effect)
    _poison.damage = round(_dmg * 0.5)
    _poison.grid_row = _grid.row
    _poison.grid_col = _grid.col

    // 溅射动画
    instance_create_depth(_x, _y, depth, obj_egg_god_bullet_effect)
}
