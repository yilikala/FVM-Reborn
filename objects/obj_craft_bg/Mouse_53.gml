if !is_submenu_opened{
	// 切换箭头与保险勾选框全 tab 通用
	var _tab_list = (button_select == 0) ? card_material_id_list
	            : ((button_select == 1) ? gem_material_id_list : spice_synthesis_material_id_list)
	if hover_switch_arrow{
		audio_play_sound(snd_button,0,0)
		var _total = array_length(_tab_list)
		material_page = (material_page + 1) mod ceil(_total / material_per_page)
	}
	else if hover_insurance_box{
		audio_play_sound(snd_button,0,0)
		insured = !insured
	}
	else if hover_material_index != -1{
		audio_play_sound(snd_button,0,0)
		var _mat_id = _tab_list[hover_material_index]
		var _is_spice = (array_get_index(spices_use_order, _mat_id) != -1)
		var _is_clover = (array_get_index(clover_use_order, _mat_id) != -1)
		if button_select == 0{
			// 卡片强化：香料可累加，四叶草替换
			if _is_spice{
				if input_spice_id == _mat_id{
					input_spice_count = min(input_spice_max, input_spice_count + 5)
				}
				else{
					show_notice("请填入相应香料",60)
				}
			}
			else if _is_clover{
				// 四叶草只能填1个，再点别的直接替换；库存为0时忽略
				if get_material_amount(_mat_id) >= 1{
					input_clover_id = _mat_id
				}
			}
		}
		else if button_select == 1{
			// 宝石强化：水晶不累加（自动固定），仅四叶草可手动填入
			if _is_clover{
				if get_material_amount(_mat_id) >= 1{
					input_clover_id = _mat_id
				}
			}
		}
		else if button_select == 2{
			// 香料合成：点香料 → 设为原料；点四叶草 → 设为四叶草
			if _is_spice{
				var _rule = get_spice_synthesis_rule(_mat_id)
				if is_undefined(_rule){
					show_notice("该香料无法继续合成",60)
				}
				else{
					syn_input_spice_id = _mat_id
					syn_input_clover_id = ""
					insured = false
				}
			}
			else if _is_clover{
				if get_material_amount(_mat_id) >= 1{
					syn_input_clover_id = _mat_id
				}
			}
		}
	}
	else if button_select == 0 && hover_card_index != -1{
		audio_play_sound(snd_button,0,0)
		current_uprade_target_id = global.save_data.unlocked_cards[hover_card_index].id
		// 自动填入基础香料
		var _cd = get_card_info_simple(current_uprade_target_id)
		if _cd.max_level <= 15{
			var _rule = get_card_craft_rule(string(_cd.max_level + 1))
			input_spice_id = _rule.spices_require
			input_spice_base = _rule.spices_amount
			input_spice_max = _rule.spices_amount * 4
			input_spice_count = _rule.spices_amount
		}
		else{
			input_spice_id = ""
			input_spice_base = 0
			input_spice_max = 0
			input_spice_count = 0
		}
		input_clover_id = ""
		insured = false
	}
	else if button_select == 1 && hover_gem_index != -1{
		audio_play_sound(snd_button,0,0)
		current_uprade_target_id = global.save_data.unlocked_gems[hover_gem_index].id
		// 自动填入基础水晶（不可累加，固定为基础量）
		var _gl = get_gem_max_level(current_uprade_target_id)
		if _gl <= 14{
			var _rule = get_gem_craft_rule(string(_gl + 1))
			input_crystal_id = _rule.crystal_require
			input_crystal_count = _rule.crystal_amount
			input_crystal_max = _rule.crystal_amount
		}
		else{
			input_crystal_id = ""
			input_crystal_count = 0
			input_crystal_max = 0
		}
		input_clover_id = ""
		insured = false
	}
}