// 鼠标滚轮下滚：卡片栏内容向下滚动（y_offset 增大，受最大偏移限制）
if package_button_select == 1 && !is_submenu_opened{
	var _total_cards = ds_list_size(global.player_deck) / 2
	var _total_rows = max(8, ceil(_total_cards / package_rows))
	var _max_offset = max(0, _total_rows * 96 - card_surface_h)
	if y_offset < _max_offset - 40{
		y_offset += 40
	}
	else{
		y_offset = _max_offset
	}
}