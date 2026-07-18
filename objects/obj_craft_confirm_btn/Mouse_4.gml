audio_play_sound(snd_button,0,0)

// 香料合成特殊分支（不需要 target_id）
if obj_craft_bg.button_select == 2{
	var _id = obj_craft_bg.syn_input_spice_id
	if _id == ""{
		show_notice("请先选择原料香料",60)
	}
	else{
		var _rule = get_spice_synthesis_rule(_id)
		if is_undefined(_rule){
			show_notice("该香料无法继续合成",60)
		}
		else if get_material_amount(_id) < _rule.required{
			show_notice("原料香料数量不足",60)
		}
		else if obj_craft_bg.syn_input_clover_id != "" && get_material_amount(obj_craft_bg.syn_input_clover_id) < 1{
			show_notice("背包中四叶草数量不足",60)
		}
		else{
			var is_insured = obj_craft_bg.insured
			var ins_cost = get_insurance_cost(5)
			if is_insured && global.save_data.player.points < ins_cost{
				show_notice("点券不足以支付保险金",60)
			}
			else{
				// 成功率
				var _base_rate = get_spice_synthesis_base_rate(_id)
				var _clover_num = (obj_craft_bg.syn_input_clover_id != "") ? 1 : 0
				var _rate = calc_synthesis_rate(_base_rate, _clover_num)
				var _roll = random(1.0)

				// 预扣保险费（无论成败）
				if is_insured{
					global.save_data.player.points -= ins_cost
				}

				if _roll < _rate{
					// 合成成功
					add_material_amount(_id, -_rule.required)
					if obj_craft_bg.syn_input_clover_id != ""{
						add_material_amount(obj_craft_bg.syn_input_clover_id, -1)
					}
					add_material_amount(_rule.output_id, 5)
					show_notice("合成成功！",60)
					// 自动重填
					obj_craft_bg.syn_last_spice_id = _id
					obj_craft_bg.syn_last_clover_id = obj_craft_bg.syn_input_clover_id
					if get_material_amount(_id) >= _rule.required{
						obj_craft_bg.syn_input_spice_id = _id
					}
					else{
						obj_craft_bg.syn_input_spice_id = ""
					}
					if obj_craft_bg.syn_last_clover_id != "" && get_material_amount(obj_craft_bg.syn_last_clover_id) >= 1{
						obj_craft_bg.syn_input_clover_id = obj_craft_bg.syn_last_clover_id
					}
					else{
						obj_craft_bg.syn_input_clover_id = ""
					}
					obj_craft_bg.insured = false
				}
				else{
					// 合成失败
					if is_insured{
						show_notice("不够好运，合成失败",60)
						obj_craft_bg.insured = false
					}
					else{
						add_material_amount(_id, -_rule.required)
						if obj_craft_bg.syn_input_clover_id != ""{
							add_material_amount(obj_craft_bg.syn_input_clover_id, -1)
						}
						show_notice("不够好运，合成失败",60)
						obj_craft_bg.syn_last_spice_id = _id
						obj_craft_bg.syn_last_clover_id = obj_craft_bg.syn_input_clover_id
						if get_material_amount(_id) >= _rule.required{
							obj_craft_bg.syn_input_spice_id = _id
						}
						else{
							obj_craft_bg.syn_input_spice_id = ""
						}
						if obj_craft_bg.syn_last_clover_id != "" && get_material_amount(obj_craft_bg.syn_last_clover_id) >= 1{
							obj_craft_bg.syn_input_clover_id = obj_craft_bg.syn_last_clover_id
						}
						else{
							obj_craft_bg.syn_input_clover_id = ""
						}
						obj_craft_bg.insured = false
					}
				}
			}
		}
	}
}
else{
var target_id = obj_craft_bg.current_uprade_target_id
if target_id != ""{
	if obj_craft_bg.button_select == 0{
		var card_data = get_card_info_simple(target_id)
		var current_level = card_data.max_level
		if array_get_index(cannot_upgrade_card_list,target_id) != -1{
			show_notice("该卡片无法被强化",60)
		}
		else if current_level > 15{
			show_notice("已达到最高星级",60)
		}
		else{
			var craft_rule_info = get_card_craft_rule(string(current_level+1))
			// 校验香料
			if obj_craft_bg.input_spice_id != craft_rule_info.spices_require{
				show_notice("请填入相应香料",60)
			}
			else if obj_craft_bg.input_spice_count < craft_rule_info.spices_amount{
				show_notice("香料不足",60)
			}
			else if get_material_amount(obj_craft_bg.input_spice_id) < obj_craft_bg.input_spice_count{
				show_notice("背包中香料数量不足",60)
			}
			else if obj_craft_bg.input_clover_id != "" && get_material_amount(obj_craft_bg.input_clover_id) < 1{
				show_notice("背包中四叶草数量不足",60)
			}
			else if global.save_data.player.gold < craft_rule_info.gold_amount{
				show_notice("金币不足",60)
			}
			else{
				var is_insured = obj_craft_bg.insured
				var ins_cost = get_insurance_cost(current_level + 1)
				if is_insured && global.save_data.player.points < ins_cost{
					show_notice("点券不足",60)
				}
				else{
// 计算成功率
				var _base_rate = get_card_base_rate(string(current_level + 1))
				var _clover_num = (obj_craft_bg.input_clover_id != "") ? 1 : 0
				var _rate = calc_reinforce_rate(_base_rate, obj_craft_bg.input_spice_count, craft_rule_info.spices_amount, _clover_num)
				var _roll = random(1.0)

					// 扣金币（无论成功失败都扣）
					global.save_data.player.gold -= craft_rule_info.gold_amount
					// 扣保险费（无论成功失败都扣）
					if is_insured{
						global.save_data.player.points -= ins_cost
					}

					if _roll < _rate{
						// 强化成功
						add_material_amount(obj_craft_bg.input_spice_id, -obj_craft_bg.input_spice_count)
						if obj_craft_bg.input_clover_id != ""{
							add_material_amount(obj_craft_bg.input_clover_id, -1)
						}
						upgrade_card(target_id, current_level + 1)
						show_notice("卡片强化成功！", 60)
						// 从新星级刷新香料投入
						var _nl = current_level + 1
						if _nl <= 15{
							var _nr = get_card_craft_rule(string(_nl + 1))
							obj_craft_bg.input_spice_id = _nr.spices_require
							obj_craft_bg.input_spice_base = _nr.spices_amount
							obj_craft_bg.input_spice_max = _nr.spices_amount * 4
							obj_craft_bg.input_spice_count = _nr.spices_amount
						}
						else{
							obj_craft_bg.input_spice_id = ""
							obj_craft_bg.input_spice_count = 0
						}
						obj_craft_bg.input_clover_id = ""
						obj_craft_bg.insured = false
					}
					else{
						// 强化失败
						if is_insured{
							// 保险生效：不消耗香料，但消耗四叶草，不掉级
							if obj_craft_bg.input_clover_id != ""{
								add_material_amount(obj_craft_bg.input_clover_id, -1)
							}
							show_notice("不够好运，强化失败",60)
							// 重置四叶草
							obj_craft_bg.input_clover_id = ""
							obj_craft_bg.insured = false
						}
						else{
							// 消耗所有投入香料和四叶草，≥5星降1星
							add_material_amount(obj_craft_bg.input_spice_id, -obj_craft_bg.input_spice_count)
							if obj_craft_bg.input_clover_id != ""{
								add_material_amount(obj_craft_bg.input_clover_id, -1)
							}
							if current_level >= 5{
								upgrade_card(target_id, current_level - 1)
							}
							show_notice("不够好运，强化失败",60)
							// 从当前星级刷新香料投入
							var _nl = (current_level >= 5) ? (current_level - 1) : current_level
							if _nl <= 15{
								var _nr = get_card_craft_rule(string(_nl + 1))
								obj_craft_bg.input_spice_id = _nr.spices_require
								obj_craft_bg.input_spice_base = _nr.spices_amount
								obj_craft_bg.input_spice_max = _nr.spices_amount * 4
								obj_craft_bg.input_spice_count = _nr.spices_amount
							}
							else{
								obj_craft_bg.input_spice_id = ""
								obj_craft_bg.input_spice_count = 0
							}
							obj_craft_bg.input_clover_id = ""
							obj_craft_bg.insured = false
						}
					}
				}
			}
		}

	}
	else if obj_craft_bg.button_select == 1{
		var current_level = get_gem_max_level(target_id)
		if array_get_index(level_10_gems,target_id) != -1 && current_level >= 10{
			show_notice("该宝石强化上限为10星",60)
		}
		else if current_level > 14{
			show_notice("已达到最高星级",60)
		}
		else{
			var craft_rule_info = get_gem_craft_rule(string(current_level+1))
			// 校验水晶
			if obj_craft_bg.input_crystal_id != craft_rule_info.crystal_require{
				show_notice("请填入相应水晶",60)
			}
			else if obj_craft_bg.input_crystal_count < craft_rule_info.crystal_amount{
				show_notice("水晶不足",60)
			}
			else if get_material_amount(obj_craft_bg.input_crystal_id) < obj_craft_bg.input_crystal_count{
				show_notice("背包中水晶数量不足",60)
			}
			else if obj_craft_bg.input_clover_id != "" && get_material_amount(obj_craft_bg.input_clover_id) < 1{
				show_notice("背包中四叶草数量不足",60)
			}
			else if global.save_data.player.gold < craft_rule_info.gold_amount{
				show_notice("金币不足",60)
			}
			else{
				var is_insured = obj_craft_bg.insured
				var ins_cost = get_insurance_cost(current_level + 1)
				if is_insured && global.save_data.player.points < ins_cost{
					show_notice("点券不足",60)
				}
				else{
					// 计算成功率（水晶不累加，按基础量计，倍率为1）
					var _base_rate = get_gem_base_rate(string(current_level + 1))
					var _clover_num = (obj_craft_bg.input_clover_id != "") ? 1 : 0
					var _rate = calc_reinforce_rate(_base_rate, obj_craft_bg.input_crystal_count, craft_rule_info.crystal_amount, _clover_num)
					var _roll = random(1.0)

					// 扣金币（无论成功失败都扣）
					global.save_data.player.gold -= craft_rule_info.gold_amount
					// 扣保险费（无论成功失败都扣）
					if is_insured{
						global.save_data.player.points -= ins_cost
					}

					if _roll < _rate{
						// 强化成功
						add_material_amount(obj_craft_bg.input_crystal_id, -obj_craft_bg.input_crystal_count)
						if obj_craft_bg.input_clover_id != ""{
							add_material_amount(obj_craft_bg.input_clover_id, -1)
						}
						edit_gem_max_level(target_id, current_level + 1)
						edit_gem_level(target_id, get_gem_max_level(target_id))
						show_notice("水晶强化成功！" , 60)
						// 从新星级刷新水晶投入
						var _nl = current_level + 1
						if _nl <= 14 && (array_get_index(level_10_gems, target_id) == -1 || _nl < 10){
							var _nr = get_gem_craft_rule(string(_nl + 1))
							obj_craft_bg.input_crystal_id = _nr.crystal_require
							obj_craft_bg.input_crystal_count = _nr.crystal_amount
							obj_craft_bg.input_crystal_max = _nr.crystal_amount
						}
						else{
							obj_craft_bg.input_crystal_id = ""
							obj_craft_bg.input_crystal_count = 0
						}
						obj_craft_bg.input_clover_id = ""
						obj_craft_bg.insured = false
					}
					else{
						// 强化失败
						if is_insured{
							// 保险生效：不消耗水晶，但消耗四叶草，不掉级
							if obj_craft_bg.input_clover_id != ""{
								add_material_amount(obj_craft_bg.input_clover_id, -1)
							}
							show_notice("不够好运，强化失败",60)
							// 重置四叶草
							obj_craft_bg.input_clover_id = ""
							obj_craft_bg.insured = false
						}
						else{
							// 消耗投入水晶和四叶草，≥5星降1星
							add_material_amount(obj_craft_bg.input_crystal_id, -obj_craft_bg.input_crystal_count)
							if obj_craft_bg.input_clover_id != ""{
								add_material_amount(obj_craft_bg.input_clover_id, -1)
							}
							if current_level >= 5{
								edit_gem_max_level(target_id, current_level - 1)
								edit_gem_level(target_id, get_gem_max_level(target_id))
							}
							show_notice("不够好运，强化失败",60)
							// 从当前星级刷新水晶投入
							var _nl = (current_level >= 5) ? (current_level - 1) : current_level
							if _nl <= 14 && (array_get_index(level_10_gems, target_id) == -1 || _nl < 10){
								var _nr = get_gem_craft_rule(string(_nl + 1))
								obj_craft_bg.input_crystal_id = _nr.crystal_require
								obj_craft_bg.input_crystal_count = _nr.crystal_amount
								obj_craft_bg.input_crystal_max = _nr.crystal_amount
							}
							else{
								obj_craft_bg.input_crystal_id = ""
								obj_craft_bg.input_crystal_count = 0
							}
							obj_craft_bg.input_clover_id = ""
							obj_craft_bg.insured = false
						}
					}
				}
			}
		}

	}
}
}