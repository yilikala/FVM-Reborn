ice_timer = 0
frozen_timer = 0

var _blacklist = ["brahma", "magic_chicken", "ice_cream"]
if target_card != "" && array_get_index(_blacklist, target_card) == -1{
	var card_save_data = get_card_info_simple(target_card)
	if card_save_data != false{
		var card_slot_data = deck_get_card_data(target_card, card_save_data.shape)
		plant_type = card_slot_data[? "plant_type"]
	}
}