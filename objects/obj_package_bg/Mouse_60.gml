// 鼠标滚轮上滚
if package_button_select == 1 && !is_submenu_opened{
	if y_offset > 40{
		y_offset -= 40
	}
	else{
		y_offset = 0
	}
}
else if package_button_select == 2 && !is_submenu_opened{
	if weapon_y_offset > 40{
		weapon_y_offset -= 40
	}
	else{
		weapon_y_offset = 0
	}
}
