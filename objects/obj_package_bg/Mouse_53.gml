if package_button_select == 1{
	if not is_submenu_opened{
		if hover_card_index != -1{
			// 进入按下状态：长按 + 拖动距离阈值后才真正开始拖拽；
			// 短按释放则由 Step 触发卡片编辑菜单打开
			drag_state = 1
			drag_hold_timer = 0
			drag_card_index = hover_card_index
			drag_deck_slot = hover_deck_slot
			drag_start_x = mouse_x
			drag_start_y = mouse_y
		}
	}
}
// 鼠标按下事件
if (package_button_select == 2) {
	if not is_submenu_opened{
	    // 武器背包标签页
	    if (hover_weapon_index != -1) {
			audio_play_sound(snd_button,0,0)
	        var weapon_id = global.save_data.unlocked_weapons[hover_weapon_index].id;
			var weapon_info = get_weapon_info(weapon_id)
	        var is_equipped = is_weapon_equipped(weapon_id);
        
	        if (is_equipped) {
	            // 如果已装备，则卸下
	            var slot = get_weapon_slot(weapon_id);
	            remove_weapon(slot);
	        } else {
	            // 如果未装备，则装备到对应武器槽
	            equip_weapon(weapon_id, weapon_info.slot);
	        }
	    }
		if (hover_gem_index != -1) {
			audio_play_sound(snd_button,0,0)
	        var weapon_id = global.save_data.unlocked_gems[hover_gem_index].id;
			var weapon_info = get_gem_info(weapon_id)
	        var is_equipped = (get_gem_index(weapon_id) != -1);
        
	        if (is_equipped) {
	            //如果已装备，则卸下
	            remove_gem(weapon_id)
	        } else {
	            // 如果未装备，则装备到对应武器槽
	            equip_gem(weapon_id);
	        }
	    }
	}
}