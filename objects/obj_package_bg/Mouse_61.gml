// 鼠标滚轮下滚
if package_button_select == 1 && !is_submenu_opened{
	var _total_cards = ds_list_size(global.player_deck) / 2
	var _total_rows = max(8, ceil(_total_cards / package_cols))
	var _max_offset = max(0, _total_rows * 96 - card_surface_h)
	if y_offset < _max_offset - 40{
		y_offset += 40
	}
	else{
		y_offset = _max_offset
	}
}
else if package_button_select == 2 && !is_submenu_opened{
	var _total_w = array_length(global.save_data.unlocked_weapons) + array_length(global.save_data.unlocked_gems)
	var _total_rows = max(8, ceil(_total_w / package_cols) + 4)
	var _max_offset = max(0, _total_rows * 88 - weapon_surface_h)
	if weapon_y_offset < _max_offset - 40{
		weapon_y_offset += 40
	}
	else{
		weapon_y_offset = _max_offset
	}
}
