if !obj_gods_hall_bg.is_submenu_opened {
	if global.save_data.player.points >= 10000 {
		if parent_gui.wish_completed {
			audio_play_sound(snd_button,0,0)
			global.save_data.player.points -= 10000
			parent_gui.start_wishing8 = true
		}
	} else {
		show_notice("点券不足",60)
	}
}