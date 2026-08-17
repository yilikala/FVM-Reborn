/// @function buff_apply(buff_card)
/// @desc Apply atk buff from a buff source card (called after atk reset to atk_base)
/// @note For same-row: sets atk = round(atk_base * mult). For adjacent: multiplies additively.
function buff_apply(buff_card){
	var _row = buff_card.grid_row
	var _mult = buff_card.atk
	var _wl = buff_card.atk_whitelist
	if !is_array(_wl) return

	var _on_edge = (buff_card.shape >= 3 && (_row == 0 || _row == global.grid_rows - 1))

	with(obj_card_parent){
		if id == buff_card.id continue

		var _found = false
		for (var _j = 0; _j < array_length(_wl); _j++){
			if plant_id == _wl[_j]{ _found = true; break }
		}
		if !_found continue

		if !variable_instance_exists(id, "atk_base"){ atk_base = atk }

		if grid_row == _row {
			var _bu = _on_edge ? (1 + (_mult - 1) * 1.2) : _mult
			atk = round(atk_base * _bu)
		}
		else if buff_card.shape >= 3 && (grid_row == _row - 1 || grid_row == _row + 1) {
			atk = round(atk * (1 + (_mult - 1) * 0.2))
		}
	}
}
