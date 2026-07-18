draw_set_alpha(0.5);
// 绘制半透明遮罩
draw_rectangle_color(0, 0, room_width, room_height, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);
draw_self()

draw_sprite_ext(spr_craft_gold_require_bg,0,x-45,y+300,1.8,1.8,0,c_white,1)

draw_set_font(font_number)
draw_set_colour(c_yellow)
draw_set_valign(fa_middle)
draw_set_halign(fa_left)

//draw_text(x-160,y+300,"300")
draw_set_halign(fa_right)
draw_text(x+758,y+473,string(global.save_data.player.gold))
// 绘制玩家点券余额
draw_text(x+492,y+473,+string(global.save_data.player.points))
draw_set_colour(c_yellow)
draw_set_valign(fa_middle)
draw_set_halign(fa_left)
// 通用材料栏迭代
var _mat_list = (button_select == 0) ? card_material_id_list
            : ((button_select == 1) ? gem_material_id_list
                                    : spice_synthesis_material_id_list)
var _mat_total = array_length(_mat_list)
var _mat_visible = min(material_per_page, _mat_total)
var _mat_page_offset = material_page * material_per_page

// 重置材料栏相关悬停
hover_material_index = -1
hover_switch_arrow = false
hover_insurance_box = false

for(var i = 0 ; i < _mat_visible ; i++){
    draw_sprite_ext(spr_package_slot_bg,1,x-752+i*84,y + 454,1.8,1.8,0,c_white,1)
}
for(var i = 0 ; i < _mat_visible ; i++){
    var _global_i = _mat_page_offset + i
    if _global_i >= _mat_total { break }
    var _mat_id = _mat_list[_global_i]
    var _mat_info = get_material_info(_mat_id)
    draw_sprite_ext(spr_craft_material,_mat_info.icon,x-752+i*84,y + 454,1.8,1.8,0,c_white,1)
    draw_set_halign(fa_right)
    draw_set_valign(fa_bottom)
    draw_set_colour(c_white)
    draw_set_font(font_number)
    var _amt = get_material_amount(_mat_id)
    if _amt < 10000{
        draw_text(x-752+i*84+40,y + 454+42,string(_amt))
    }
    else{
        draw_text(x-752+i*84+40,y + 454+42,string(floor(_amt/10000))+"w")
    }
// 悬停检测
    if point_in_rectangle(mouse_x, mouse_y,
                          x-752+i*84-42, y + 454-42,
                          x-752+i*84+42, y + 454+42){
        hover_material_index = _global_i
    }
    // 高亮当前已投入的材料
    var _is_match = false
    if button_select == 0{
        _is_match = (input_spice_id == _mat_id || input_clover_id == _mat_id)
    }
    else if button_select == 1{
        _is_match = (input_crystal_id == _mat_id || input_clover_id == _mat_id)
    }
    else if button_select == 2{
        _is_match = (syn_input_spice_id == _mat_id || syn_input_clover_id == _mat_id)
    }
    if _is_match{
        draw_set_color(c_yellow)
        draw_rectangle(x-752+i*84-42, y + 454-42,
                       x-752+i*84+42, y + 454+42, true)
        draw_set_color(c_white)
    }
}

// 切换箭头（总材料数超过单页时显示，卡片/宝石强化页均适用）
if _mat_total > material_per_page{
    var _ax = x - 1602 + (material_per_page + 0) * 84 + 16
    var _ay = y + 385
    // 悬停检测
    if point_in_rectangle(mouse_x, mouse_y, _ax - 24, _ay - 24, _ax + 24, _ay + 24){
        hover_switch_arrow = true
    }
    draw_set_color(hover_switch_arrow ? c_yellow : c_white)
    draw_triangle(_ax - 14, _ay - 16, _ax - 14, _ay + 16, _ax + 14, _ay, false)
    draw_set_color(c_white)
}

if button_select == 0{
	//绘制卡片强化UI背景
	draw_sprite_ext(spr_craft_slot_bg,0,x-305,y+100,1.8,1.8,0,c_white,1)
	draw_sprite_ext(spr_craft_material_bg,0,x-455,y-20,1.8,1.8,0,c_white,1)
	draw_sprite_ext(spr_craft_material_bg,0,x-155,y-20,1.8,1.8,0,c_white,1)
	draw_sprite_ext(spr_craft_slot_text,0,x-305,y+100,1.8,1.8,0,c_white,1)
	draw_sprite_ext(spr_craft_slot_text,1,x-455,y-20,1.8,1.8,0,c_white,1)
	draw_sprite_ext(spr_craft_slot_text,2,x-155,y-20,1.8,1.8,0,c_white,1)
	surface_set_target(card_surface)
	//绘制右侧栏位
	for(var i = 0 ; i < 7 ; i++){
        for(var j = 0 ; j < 20 ; j++){
            draw_sprite_ext(spr_package_slot_bg,0,42+i*84,48+96 * j-y_offset,1.8,1.8,0,c_white,1)
        }
    }
	//绘制所有已解锁防御卡
	var card_index = 0
	hover_card_index = -1
	for(var i = 0 ; i < array_length(global.save_data.unlocked_cards);i++){
		var card_col = card_index mod 7
		var card_row = card_index div 7
		var card_data = global.save_data.unlocked_cards[i]
		var card_id = card_data.id
		var card_slot_data = deck_get_card_data(card_id,card_data.shape)
		var card_x = 42 + card_col*84
		var card_y = 48+96 * card_row - y_offset

		if (card_slot_data != noone) {
			draw_sprite_ext(get_slot_sprite(card_slot_data),0,card_x,card_y-3,0.25,0.25,0,c_white,1)
			draw_sprite_ext(card_slot_data[? "sprite"],0,card_x,card_y+15,0.7,0.7,0,c_white,1)
			draw_set_color(c_black);
			draw_set_halign(fa_center);
			draw_set_valign(fa_bottom);
			draw_set_font(font_pixel)
			draw_text(card_x,card_y+37,card_slot_data[? "cost"])
			if card_data.max_level > 0{
				draw_sprite_ext(spr_star_slot, card_data.max_level - 1, card_x-25, card_y-35,1.4,1.4,0,c_white,1);
			}
		}
		
		// 检查鼠标是否悬停在卡片上
        var spr_width = 84;
        var spr_height = 96;
		
		var hover_card_x = x + 196 + card_col*84
		var hover_card_y = y - 321 + 96 * card_row - y_offset
		
		if mouse_y > y-321-48 && mouse_y < y + 450{
                
	        if (point_in_rectangle(mouse_x, mouse_y, 
	                                hover_card_x - spr_width/2, hover_card_y - spr_height/2,
	                                hover_card_x + spr_width/2, hover_card_y + spr_height/2)) {
	            hover_card_index = card_index;
	        }
		}
		card_index++
	}
	surface_reset_target()
	draw_surface(card_surface,x+196-42,y-321-48)
	
	//绘制悬停提示
	if (hover_card_index != -1) {
        
		draw_set_font(font_yuan)
        // 获取鼠标位置
        var tooltip_x = mouse_x - 15;
        var tooltip_y = mouse_y - 15;
            
		// 获取提示文本
        var tooltip_text = "点击将卡片放入强化槽"
        
			
        // 绘制提示背景
        draw_set_color(c_black);
        draw_set_alpha(0.7);
        draw_rectangle(tooltip_x - string_width(tooltip_text) - 5, tooltip_y - 5, 
                        tooltip_x +5, tooltip_y + string_height(tooltip_text)+5, false);
		//绘制提示文本
		draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_set_alpha(1);
        draw_set_color(c_white);
		draw_set_font(font_yuan)
		draw_text(tooltip_x- string_width(tooltip_text), tooltip_y, tooltip_text);
			
            
    }
	//绘制正在强化的卡片
	if current_uprade_target_id != ""{
		var card_data = get_card_info_simple(current_uprade_target_id)
		var card_id = card_data.id
		var card_slot_data = deck_get_card_data(current_uprade_target_id,card_data.shape)
		var card_x = x - 307
		var card_y = y + 103
		
		draw_sprite_ext(get_slot_sprite(card_slot_data),0,card_x,card_y-3,0.25,0.25,0,c_white,1)
		draw_sprite_ext(card_slot_data[? "sprite"],0,card_x,card_y+15,0.7,0.7,0,c_white,1)
		draw_set_color(c_black);
		draw_set_halign(fa_center);
		draw_set_valign(fa_bottom);
		draw_set_font(font_pixel)
		draw_text(card_x,card_y+37,card_slot_data[? "cost"])
		if card_data.max_level > 0{
			draw_sprite_ext(spr_star_slot, card_data.max_level - 1, card_x-25, card_y-35,1.4,1.4,0,c_white,1);
		}
		//绘制强化需要的材料
		if card_data.max_level <= 15{
			var craft_rule = get_card_craft_rule(string(card_data.max_level+1))
			// 金币消耗
			draw_set_font(font_number)
			draw_set_colour(c_yellow)
			draw_set_valign(fa_middle)
			draw_set_halign(fa_left)
			draw_text(x-160,y+300,string(craft_rule.gold_amount))

// 香料槽：显示玩家投入
			if input_spice_id != ""{
				var _spice_info = get_material_info(input_spice_id)
				draw_sprite_ext(spr_craft_material,_spice_info.icon,x-455,y-20,1.8,1.8,0,c_white,1)
				draw_set_halign(fa_center)
				draw_set_valign(fa_middle)
				draw_set_font(font_number)
				draw_set_colour(c_black)
				draw_text(x-455,y+35,string(input_spice_count)+"/"+string(input_spice_max))
			}
			else{
				draw_set_halign(fa_center)
				draw_set_valign(fa_middle)
				draw_set_font(font_yuan)
				draw_set_colour(c_gray)
				draw_text(x-455,y+35,"未投入")
			}
			draw_set_font(font_yuan)
			draw_set_colour(c_white)

			// 四叶草槽：仅在投入时显示图标
			if input_clover_id != ""{
				var _clover_info = get_material_info(input_clover_id)
				draw_sprite_ext(spr_craft_material,_clover_info.icon,x-155,y-20,1.8,1.8,0,c_white,1)
			}
			else{
				draw_set_halign(fa_center)
				draw_set_valign(fa_middle)
				draw_set_font(font_yuan)
				draw_set_colour(c_gray)
				draw_text(x-155,y+35,"未投入")
				draw_set_font(font_yuan)
				draw_set_colour(c_white)
			}

			// 保险金：D消耗 + 下方居中勾选框
			var _can_insure = (card_data.max_level >= 0)
			var _ins_cost = get_insurance_cost(card_data.max_level + 1)
			var _bx = x - 102
			var _by = y + 163
			// 消耗D
			draw_set_halign(fa_center)
			draw_set_valign(fa_middle)
			draw_set_font(font_yuan)
			draw_set_colour(_can_insure ? c_white : c_gray)
			draw_text(_bx, _by, string(_ins_cost))
			draw_set_colour(c_yellow)
			// 下方居中勾选框
			var _bx_box = _bx
			var _by_box = _by + 65
			if _can_insure && point_in_rectangle(mouse_x, mouse_y, _bx_box - 16, _by_box - 16, _bx_box + 16, _by_box + 16){
				hover_insurance_box = true
			}
			if _can_insure && insured{
				draw_set_color(c_yellow)
				draw_rectangle(_bx_box - 12, _by_box - 12, _bx_box + 12, _by_box + 12, false)
			}
			draw_set_color(c_white)

			// 成功率显示（最终成功率，>=100 显示100）
			var _base_rate = get_card_base_rate(string(card_data.max_level + 1))
			var _clover_num = (input_clover_id != "") ? 1 : 0
			var _rate = calc_reinforce_rate(_base_rate, input_spice_count, craft_rule.spices_amount, _clover_num)
			var _disp_rate = floor(_rate * 100)
			if _disp_rate > 100 { _disp_rate = 100 }
			draw_set_halign(fa_center)
			draw_set_valign(fa_middle)
			draw_set_font(font_yuan)
			draw_set_colour(c_yellow)
			draw_set_font(font_number)
			draw_text(x-345, y+300, string(_disp_rate) + "%")
			draw_set_colour(c_white)
			draw_set_font(font_yuan)
		}
	}
}
else if button_select == 1{
	//绘制宝石强化UI背景
	draw_sprite_ext(spr_package_gem_bg,0,x-305,y+110,1.8,1.8,0,c_white,1)
	draw_sprite_ext(spr_craft_material_bg,0,x-455,y-20,1.8,1.8,0,c_white,1)
	draw_sprite_ext(spr_craft_material_bg,0,x-155,y-20,1.8,1.8,0,c_white,1)
	draw_sprite_ext(spr_craft_slot_text,3,x-305,y+110,1.8,1.8,0,c_white,1)
	draw_sprite_ext(spr_craft_slot_text,4,x-455,y-20,1.8,1.8,0,c_white,1)
	draw_sprite_ext(spr_craft_slot_text,2,x-155,y-20,1.8,1.8,0,c_white,1)
	//绘制右侧栏位
	for(var i = 0 ; i < 7 ; i++){
        for(var j = 0 ; j < 9 ; j++){
            draw_sprite_ext(spr_package_slot_bg,1,x+196+i*84,y - 324 + 88 * j,1.8,1.8,0,c_white,1)
        }
    }
	//绘制所有宝石
	var gem_index = 0
	hover_gem_index = -1
	
	for(var i = 0; i < array_length(global.save_data.unlocked_gems); i++) {
        var weapon_id = global.save_data.unlocked_gems[i].id;
        var weapon_data = get_gem_info(weapon_id)
        
        if (!is_undefined(weapon_data)) {
            // 计算宝石位置
            var row = gem_index div 7
            var col = gem_index mod 7
            
            if (row < 10) {
                var weapon_x = x + 196 + col * 84;
                var weapon_y = y - 324 + row * 88;
                
                // 绘制宝石图标
                draw_sprite_ext(weapon_data.icon, 0, weapon_x, weapon_y, 1.4, 1.4, 0, c_white, 1);
                
				if get_gem_max_level(weapon_id) > 0{
					draw_sprite_ext(spr_star_slot,get_gem_max_level(weapon_id)-1,weapon_x-28,weapon_y-30,1.4,1.4,0,c_white,1)
				}
                
                // 检查鼠标是否悬停在宝石上
                var spr_width = 84;
                var spr_height = 88;
                
                if (point_in_rectangle(mouse_x, mouse_y, 
                                      weapon_x - spr_width/2, weapon_y - spr_height/2,
                                      weapon_x + spr_width/2, weapon_y + spr_height/2)) {
                    hover_gem_index = i;
                }
                
                gem_index++;
            }
        }
    }
    
    // 绘制悬停提示
    if (hover_gem_index != -1) {
        var weapon_id = global.save_data.unlocked_gems[hover_gem_index].id;
        var weapon_data = global.gems_pool[? weapon_id];
        
        if (!is_undefined(weapon_data)) {
			draw_set_font(font_yuan)
            // 获取鼠标位置
            var tooltip_x = mouse_x - 15;
            var tooltip_y = mouse_y - 15;
            
			// 获取提示文本
            
            var tooltip_text = weapon_data.name
            var is_equipped = is_weapon_equipped(weapon_id);
            
            var slot = get_weapon_slot(weapon_id);
            tooltip_text += "\n点击将宝石放入强化槽"
            
			
            // 绘制提示背景
            draw_set_color(c_black);
            draw_set_alpha(0.7);
            draw_rectangle(tooltip_x - string_width(tooltip_text) - 5, tooltip_y - 5, 
                          tooltip_x +5, tooltip_y + string_height(tooltip_text)+5, false);
			//绘制提示文本
			draw_set_halign(fa_left);
            draw_set_valign(fa_top);
            draw_set_alpha(1);
            draw_set_color(c_white);
			draw_set_font(font_yuan)
			draw_text(tooltip_x- string_width(tooltip_text), tooltip_y, tooltip_text);
			
            
        }
    }
	//绘制正在强化的宝石
	if current_uprade_target_id != ""{
		var weapon_x = x - 305
        var weapon_y = y + 110
		var weapon_id = current_uprade_target_id
		var weapon_data = get_gem_info(weapon_id)
                
        // 绘制宝石图标
        draw_sprite_ext(weapon_data.icon, 0, weapon_x, weapon_y, 1.7, 1.7, 0, c_white, 1);
                
		if get_gem_max_level(weapon_id) > 0{
			draw_sprite_ext(spr_star_slot,get_gem_max_level(weapon_id)-1,weapon_x-28,weapon_y-30,1.6,1.6,0,c_white,1)
		}
//绘制强化需要的材料
		if get_gem_max_level(weapon_id) <= 14{
			var craft_rule = get_gem_craft_rule(string(get_gem_max_level(weapon_id)+1))
			// 金币消耗
			draw_set_font(font_number)
			draw_set_colour(c_yellow)
			draw_set_valign(fa_middle)
			draw_set_halign(fa_left)
			draw_text(x-160,y+300,string(craft_rule.gold_amount))

			// 水晶槽：显示玩家投入（不可累加，固定为基础量）
			if input_crystal_id != ""{
				var _crystal_info = get_material_info(input_crystal_id)
				draw_sprite_ext(spr_craft_material,_crystal_info.icon,x-455,y-20,1.8,1.8,0,c_white,1)
				draw_set_halign(fa_center)
				draw_set_valign(fa_middle)
				draw_set_font(font_number)
				draw_set_colour(c_black)
				draw_text(x-455,y+35,string(input_crystal_count)+"/"+string(input_crystal_max))
			}
			else{
				draw_set_halign(fa_center)
				draw_set_valign(fa_middle)
				draw_set_font(font_yuan)
				draw_set_colour(c_gray)
				draw_text(x-455,y+35,"未投入")
			}
			draw_set_font(font_yuan)
			draw_set_colour(c_white)

			// 四叶草槽：仅在投入时显示图标
			if input_clover_id != ""{
				var _clover_info = get_material_info(input_clover_id)
				draw_sprite_ext(spr_craft_material,_clover_info.icon,x-155,y-20,1.8,1.8,0,c_white,1)
			}
			else{
				draw_set_halign(fa_center)
				draw_set_valign(fa_middle)
				draw_set_font(font_yuan)
				draw_set_colour(c_gray)
				draw_text(x-155,y+35,"未投入")
				draw_set_font(font_yuan)
				draw_set_colour(c_white)
			}

			// 保险金：D消耗 + 下方居中勾选框
			var _can_insure = (get_gem_max_level(weapon_id) >= 0)
			var _ins_cost = get_insurance_cost(get_gem_max_level(weapon_id) + 1)
			var _bx = x - 102
			var _by = y + 163
			// 消耗D
			draw_set_halign(fa_center)
			draw_set_valign(fa_middle)
			draw_set_font(font_yuan)
			draw_set_colour(_can_insure ? c_white : c_gray)
			draw_text(_bx, _by, string(_ins_cost))
			draw_set_colour(c_yellow)
			// 下方居中勾选框
			var _bx_box = _bx
			var _by_box = _by + 65
			if _can_insure && point_in_rectangle(mouse_x, mouse_y, _bx_box - 16, _by_box - 16, _bx_box + 16, _by_box + 16){
				hover_insurance_box = true
			}
			if _can_insure && insured{
				draw_set_color(c_yellow)
				draw_rectangle(_bx_box - 12, _by_box - 12, _bx_box + 12, _by_box + 12, false)
			}
			draw_set_color(c_white)

			// 成功率显示（最终成功率，>=100 显示100）
			var _base_rate = get_gem_base_rate(string(get_gem_max_level(weapon_id) + 1))
			var _clover_num = (input_clover_id != "") ? 1 : 0
			var _rate = calc_reinforce_rate(_base_rate, input_crystal_count, craft_rule.crystal_amount, _clover_num)
			var _disp_rate = floor(_rate * 100)
			if _disp_rate > 100 { _disp_rate = 100 }
			draw_set_halign(fa_center)
			draw_set_valign(fa_middle)
			draw_set_font(font_yuan)
			draw_set_colour(c_yellow)
			draw_set_font(font_number)
			draw_text(x-345, y+300, string(_disp_rate) + "%")
			draw_set_colour(c_white)
			draw_set_font(font_yuan)
		}
	}
}
else if button_select == 2{
	draw_sprite_ext(spr_package_gem_bg,0,x-305,y+110,1.8,1.8,0,c_white,1)
	draw_sprite_ext(spr_craft_material_bg,0,x-305,y-40,1.8,1.8,0,c_white,1)
	draw_sprite_ext(spr_craft_slot_text,1,x-305,y-40,1.8,1.8,0,c_white,1)
	draw_sprite_ext(spr_craft_slot_text,2,x-305,y+110,1.8,1.8,0,c_white,1)
	//绘制右侧栏位
	for(var i = 0 ; i < 7 ; i++){
        for(var j = 0 ; j < 9 ; j++){
            draw_sprite_ext(spr_package_slot_bg,1,x+196+i*84,y - 324 + 88 * j,1.8,1.8,0,c_white,1)
        }
    }
	//绘制合成内容
	if syn_input_spice_id != ""{
		var _rule = get_spice_synthesis_rule(syn_input_spice_id)
		if !is_undefined(_rule){
			// 原料香料图标显示在上槽
			var _spice_info = get_material_info(syn_input_spice_id)
			draw_sprite_ext(spr_craft_material,_spice_info.icon,x-305,y-40,1.8,1.8,0,c_white,1)
			draw_set_halign(fa_center)
			draw_set_valign(fa_middle)
			draw_set_font(font_number)
			draw_set_colour(c_black)
			draw_text(x-305,y+15,string(get_material_amount(syn_input_spice_id))+"/"+string(_rule.required))
			draw_set_font(font_yuan)
			draw_set_colour(c_white)
			draw_set_font(font_number)
			draw_set_colour(c_yellow)
			draw_set_valign(fa_middle)
			draw_set_halign(fa_left)
			draw_text(x-160,y+300,string(_rule.gold_amount))
			var _can_operate = (syn_input_spice_id != "")
			//保险金
			var _bx = x - 102
			var _by = y + 163
			draw_set_halign(fa_center)
			draw_set_valign(fa_middle)
			draw_set_font(font_yuan)
			draw_set_colour(_can_operate ? c_white : c_gray)
			draw_text(_bx, _by, string(_rule.insurance))
			draw_set_colour(c_yellow)
			var _bx_box = _bx
			var _by_box = _by + 65
			if _can_operate && point_in_rectangle(mouse_x, mouse_y, _bx_box - 16, _by_box - 16, _bx_box + 16, _by_box + 16){
				hover_insurance_box = true
			}
			if _can_operate && insured{
				draw_set_color(c_yellow)
				draw_rectangle(_bx_box - 12, _by_box - 12, _bx_box + 12, _by_box + 12, false)
			}
			draw_set_color(c_white)
			// 产物图标显示在下槽（仅当未选四叶草时；若选了四叶草则优先显示四叶草）
			if syn_input_clover_id == ""{
				var _out_info = get_material_info(_rule.output_id)
				draw_sprite_ext(spr_craft_material,_out_info.icon,x-305,y+110,1.8,1.8,0,c_white,1)
				draw_set_halign(fa_center)
				draw_set_valign(fa_middle)
				draw_set_font(font_yuan)
				draw_set_colour(c_black)
				draw_text(x-305,y+165,"→ "+get_material_info(_rule.output_id).name+" x5")
				draw_set_colour(c_white)
			}
		}
	}
	// 四叶草显示
	if syn_input_clover_id != ""{
		var _clover_info = get_material_info(syn_input_clover_id)
		draw_sprite_ext(spr_craft_material,_clover_info.icon,x-305,y+110,1.8,1.8,0,c_white,1)
	}
	// 成功率
	if syn_input_spice_id != "" && !is_undefined(get_spice_synthesis_rule(syn_input_spice_id)){
		var _base_rate = get_spice_synthesis_base_rate(syn_input_spice_id)
		var _clover_num = (syn_input_clover_id != "") ? 1 : 0
		var _rate = calc_synthesis_rate(_base_rate, _clover_num)
		var _disp_rate = floor(_rate * 100)
		if _disp_rate > 100 { _disp_rate = 100 }
		draw_set_halign(fa_center)
		draw_set_valign(fa_middle)
		draw_set_font(font_yuan)
		draw_set_colour(c_yellow)
		draw_set_font(font_number)
		draw_text(x-345, y+300, string(_disp_rate) + "%")
		draw_set_colour(c_white)
		draw_set_font(font_yuan)
	}

}