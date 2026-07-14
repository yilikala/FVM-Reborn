function get_slot_sprite(card_data){
	if is_struct(card_data) && struct_exists(card_data, "is_gold"){
		return spr_slot_1
	}
	if !is_struct(card_data) && ds_map_exists(card_data, "is_gold"){
		return spr_slot_1
	}
	return spr_slot
}
