if instance_exists(obj_craft_bg){
	if obj_craft_bg.button_select != button_index{
		obj_craft_bg.button_select = button_index
		obj_craft_bg.current_uprade_target_id = ""
		obj_craft_bg.y_offset = 0
		obj_craft_bg.material_page = 0
		obj_craft_bg.input_clover_id = ""
		obj_craft_bg.insured = false
		obj_craft_bg.input_spice_id = ""
		obj_craft_bg.input_crystal_id = ""
		obj_craft_bg.syn_input_spice_id = ""
		obj_craft_bg.syn_input_clover_id = ""
		audio_play_sound(snd_button,0,0)
	}
}