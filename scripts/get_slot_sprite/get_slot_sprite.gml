function get_slot_sprite(card_data){
	if is_struct(card_data) && struct_exists(card_data, "is_fusion"){
		return spr_slot_2
	}
	if !is_struct(card_data) && ds_map_exists(card_data, "is_fusion"){
		return spr_slot_2
	}
	if is_struct(card_data) && struct_exists(card_data, "is_gold"){
		return spr_slot_1
	}
	if !is_struct(card_data) && ds_map_exists(card_data, "is_gold"){
		return spr_slot_1
	}
	if is_struct(card_data) && struct_exists(card_data, "is_special"){
		return spr_slot_3
	}
	if !is_struct(card_data) && ds_map_exists(card_data, "is_special"){
		return spr_slot_3
	}
	return spr_slot
}
