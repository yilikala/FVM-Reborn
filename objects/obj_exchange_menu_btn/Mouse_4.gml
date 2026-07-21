if instance_exists(parent_bg) {
	audio_play_sound(snd_button,0,0)
	parent_bg.execute_exchange(slot_index)
}