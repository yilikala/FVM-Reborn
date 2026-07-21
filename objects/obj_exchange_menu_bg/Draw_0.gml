draw_set_alpha(0.5)
draw_rectangle_color(0, 0, room_width, room_height, c_black, c_black, c_black, c_black, false)
draw_set_alpha(1)
draw_self()

function draw_recipe(_cx, _cy, _r){

	// 消耗材料图标
	if _r.cost_item_id != ""{
		var _info = get_material_info(_r.cost_item_id)
		draw_sprite_ext(spr_craft_material, _info.icon, _cx - 203, _cy - 3, 1.9, 1.9, 0, c_white, 1)
		draw_set_colour(c_white)
		draw_set_font(font_number)
		draw_set_halign(fa_middle)
		draw_set_valign(fa_middle)
		draw_set_font(font_yuan); 
		draw_set_color(c_black);
		draw_text(_cx - 203, _cy + 58, "x"+string(_r.cost_item_amount))
		draw_text(_cx - 305, _cy + 58, string(_r.cost_gold)+"G" )
	}
	// 产物图标
	if _r.reward_item_id != ""{
		var _info = get_material_info(_r.reward_item_id)
		draw_sprite_ext(spr_craft_material, _info.icon, _cx + 88, _cy - 3, 1.9, 1.9, 0, c_white, 1)
		draw_set_colour(c_white)
		draw_set_font(font_number)
		draw_set_halign(fa_left)
		draw_set_valign(fa_middle)
		//draw_text(_cx + 75, _cy - 30, "x" + string(_r.reward_item_amount))
		draw_set_color(c_yellow)
	}
}

// 8个兑换栏：左四右四
var _lx = x - 340
var _rx = x + 405

for (var _row = 0; _row < 4; _row++){
	var _row_y = y - 160 + _row * 170
	// 左栏背景
	draw_sprite_ext(spr_exchange_goods_bg, 0, _lx, _row_y, 1.8, 1.8, 0, c_white, 1)
	// 右栏背景
	draw_sprite_ext(spr_exchange_goods_bg, 0, _rx, _row_y, 1.8, 1.8, 0, c_white, 1)

	// 左侧配方
	var _li = _row * 2
	if _li < array_length(exchange_recipes){
		draw_recipe(_lx, _row_y, exchange_recipes[_li])
	}
	// 右侧配方
	var _ri = _row * 2 + 1
	if _ri < array_length(exchange_recipes){
		draw_recipe(_rx, _row_y, exchange_recipes[_ri])
	}
}