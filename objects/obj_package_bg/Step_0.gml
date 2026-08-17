// 拖拽状态机：仅卡片栏生效
if package_button_select != 1 || is_submenu_opened {
    drag_state = 0
    drag_card_index = -1
    drag_deck_slot = -1
    exit
}

if drag_state == 1 {
    // 按下中：判定是否进入拖拽
    if mouse_check_button(mb_left) {
        drag_hold_timer++
        var _dx = mouse_x - drag_start_x
        var _dy = mouse_y - drag_start_y
        // 长按 ~0.3s 或移动距离 > 8px 触发拖拽
        if drag_hold_timer >= 18 || (_dx*_dx + _dy*_dy) > 64 {
            drag_state = 2
        }
    } else {
        // 短按释放 → 打开卡片编辑菜单（原 Mouse_53 行为）
        if drag_card_index != -1 {
            audio_play_sound(snd_button, 0, 0)
            var inst = instance_create_depth(room_width/2, room_height/2, depth-5, obj_card_edit_menu)
            inst.target_card_index = drag_deck_slot
            var deck_entry = global.player_deck[| drag_deck_slot*2 + 1]
            var card_data_shapes = deck_entry[? "shapes"]
            view_max_shapes = ds_list_size(card_data_shapes) - 1
            inst.view_max_shape = view_max_shapes
            is_submenu_opened = true
        }
        drag_state = 0
        drag_card_index = -1
        drag_deck_slot = -1
        drag_hold_timer = 0
    }
}
else if drag_state == 2 {
    if !mouse_check_button(mb_left) {
        // 拖拽释放：若位于另一张已解锁卡上则交换 player_deck 位置
        if hover_card_index != -1 && hover_card_index != drag_card_index && hover_deck_slot != -1 {
            var _s0 = drag_deck_slot * 2
            var _s1 = hover_deck_slot * 2
            var _id0  = global.player_deck[| _s0]
            var _data0 = global.player_deck[| _s0 + 1]
            global.player_deck[| _s0]     = global.player_deck[| _s1]
            global.player_deck[| _s0 + 1] = global.player_deck[| _s1 + 1]
            global.player_deck[| _s1]     = _id0
            global.player_deck[| _s1 + 1] = _data0
            audio_play_sound(snd_button, 0, 0)
            // 持久化新顺序到存档
            var _new_order = []
            var _deck_size = ds_list_size(global.player_deck)
            for (var _oi = 0; _oi < _deck_size; _oi += 2) {
                array_push(_new_order, global.player_deck[| _oi])
            }
            global.save_data.deck_order = _new_order
            save_file(global.save_slot)
        }
        drag_state = 0
        drag_card_index = -1
        drag_deck_slot = -1
        drag_hold_timer = 0
    }
}