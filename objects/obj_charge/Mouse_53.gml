var _hx = mouse_x - x
var _hy = mouse_y - y
var _hw = sprite_width div 2
var _hh = sprite_height div 2

// 关闭按钮（右上角 ~64x64 区域）
if (_hx > _hw - 70 && _hx < _hw && _hy > -_hh && _hy < -_hh + 70){
	audio_play_sound(snd_button,0,0)
	obj_player_info_ui.menu_type = 0
	obj_world_map_button.world_map = 0
	instance_destroy()
	exit
}

// 确认充值按钮（中下方 ~200x80 区域）
if (_hx > -120 && _hx < 120 && _hy > _hh - 200 && _hy < _hh - 100){
	audio_play_sound(snd_button,0,0)
	var egg = irandom_range(1,100)
	if egg <= 80{
		show_notice("不够好运，充值失败！",60)
		obj_player_info_ui.menu_type = 0
		obj_world_map_button.world_map = 0
		instance_destroy()
	exit
	}else{
	global.save_data.player.points += 100000;
	show_notice("充值成功!", 120)
	}
}
