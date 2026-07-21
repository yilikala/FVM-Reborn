if start_wishing8 {
	is_wishing = true;
	wish_completed = false;
	wish_round++;
	reward_list = [];
	start_wishing8 = false;

	global.save_data.player.wish_spent += 10000
	var _spent = global.save_data.player.wish_spent

	var _pity = ""
	if _spent > 0 && _spent % 200000 == 0 {
		_pity = "big"
	} else if _spent > 0 && _spent % 50000 == 0 {
		_pity = "small"
	}

	for (var i = 0; i < 8; i++){
		if i == 0 && _pity != "" {
			reward_id = (_pity == "big") ? gods_hall_get_big_pity_reward() : gods_hall_get_small_pity_reward()
		} else {
			reward_id = gods_hall_get_random_reward()
		}
		switch(reward_id[0]){
			case "金币": global.save_data.player.gold += reward_id[1]; break;
			case "神谕之石": add_material_amount("oracle_stone", reward_id[1]); break;
			case "天然香料": add_material_amount("natural_spices", reward_id[1]); break;
			case "秘制香料": add_material_amount("secret_spices", reward_id[1]); break;
			case "皇室香料": add_material_amount("royal_spices", reward_id[1]); break;
			case "魔幻香料": add_material_amount("magical_spices", reward_id[1]); break;
			case "精灵香料": add_material_amount("elven_spices", reward_id[1]); break;
			case "圣灵香料": add_material_amount("holyspirit_spices", reward_id[1]); break;
			case "1级四叶草": add_material_amount("clover_1", reward_id[1]); break;
			case "2级四叶草": add_material_amount("clover_2", reward_id[1]); break;
			case "3级四叶草": add_material_amount("clover_3", reward_id[1]); break;
			case "4级四叶草": add_material_amount("clover_4", reward_id[1]); break;
			case "5级四叶草": add_material_amount("clover_5", reward_id[1]); break;
			case "6级四叶草": add_material_amount("clover_6", reward_id[1]); break;
			case "S级四叶草": add_material_amount("clover_S", reward_id[1]); break;
			case "SS四叶草": add_material_amount("clover_SS", reward_id[1]); break;
			case "SSS四叶草": add_material_amount("clover_SSS", reward_id[1]); break;
			case "SSR四叶草": add_material_amount("clover_SSR", reward_id[1]); break;
		}
		array_push(reward_list, reward_id);
	}
	save_file(global.save_slot)
}