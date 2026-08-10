// 绘制事件
draw_set_alpha(0.5);
// 绘制半透明遮罩
draw_rectangle_color(0, 0, room_width, room_height, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);
draw_self()

// 绘制背包格子背景
draw_sprite_ext(spr_package_bg_2,0,530,room_height/2,1.8,1.8,0,c_white,1)

// 绘制玩家金币数量
draw_set_font(font_number); 
draw_set_color(c_yellow);
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);
draw_text(x - 180, y + 406, string(global.save_data.player.gold));

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_set_font(font_yuan)
if info_button_select == 1{
	//绘制武器栏位文字
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_color(c_white);
	draw_text(x - 1220, y - 380, "主武器");
	draw_text(x - 1220, y -120, "副武器");
	draw_text(x - 1220, y + 140, "超级武器");
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_bottom);
	draw_set_font(font_yuan)
	//绘制武器栏位
	var _slot_id_list = ["main_weapon","secondary_weapon","super_weapon"]
	for(var i = 0;i < 3; i++){
		draw_sprite_ext(spr_package_weapon_bg,0,x-1180,y-320+260*i,2,2,0,c_white,1)
		var _wid = variable_struct_get(global.save_data.equipped_items, _slot_id_list[i]).id
		var _slot_limit = get_weapon_slot_limit(_wid)
		for(var j = 0; j < _slot_limit ; j++){
			draw_sprite_ext(spr_package_gem_bg,0,x-1180+200*j,y-220+260*i,1.8,1.8,0,c_white,1)
		}
	}
	if global.save_data.equipped_items.main_weapon.id != ""{
		var main_weapon_icon = get_weapon_info(global.save_data.equipped_items.main_weapon.id).icon
		draw_sprite_ext(main_weapon_icon,0,x-1180,y-320,1,1,0,c_white,1)
		var gem_list = global.save_data.equipped_items.main_weapon.gems
		for(var i = 0 ; i < array_length(gem_list);i++){
			var gem_icon = get_gem_info(gem_list[i]).icon
			draw_sprite_ext(gem_icon,0,x-1180+200*i,y-220,1.7,1.7,0,c_white,1)
			if get_gem_level(gem_list[i]) > 0{
				draw_sprite_ext(spr_star_slot,get_gem_level(gem_list[i])-1,x-1205+200*i,y-246,1.6,1.6,0,c_white,1)
			}
		}
	}
	if global.save_data.equipped_items.secondary_weapon.id != ""{
		var main_weapon_icon = get_weapon_info(global.save_data.equipped_items.secondary_weapon.id).icon
		draw_sprite_ext(main_weapon_icon,0,x-1180,y-60,1,1,0,c_white,1)
		var gem_list = global.save_data.equipped_items.secondary_weapon.gems
		for(var i = 0 ; i < array_length(gem_list);i++){
			var gem_icon = get_gem_info(gem_list[i]).icon
			draw_sprite_ext(gem_icon,0,x-1180+200*i,y+40,1.7,1.7,0,c_white,1)
			if get_gem_level(gem_list[i]) > 0{
				draw_sprite_ext(spr_star_slot,get_gem_level(gem_list[i])-1,x-1205+200*i,y+14,1.6,1.6,0,c_white,1)
			}
		}
	}
	if global.save_data.equipped_items.super_weapon.id != ""{
		var main_weapon_icon = get_weapon_info(global.save_data.equipped_items.super_weapon.id).icon
		draw_sprite_ext(main_weapon_icon,0,x-1180,y+200,1,1,0,c_white,1)
		var gem_list = global.save_data.equipped_items.super_weapon.gems
		for(var i = 0 ; i < array_length(gem_list);i++){
			var gem_icon = get_gem_info(gem_list[i]).icon
			draw_sprite_ext(gem_icon,0,x-1180+200*i,y+300,1.7,1.7,0,c_white,1)
			if get_gem_level(gem_list[i]) > 0{
				draw_sprite_ext(spr_star_slot,get_gem_level(gem_list[i])-1,x-1205+200*i,y+274,1.6,1.6,0,c_white,1)
			}
		}
	}
	//draw_sprite_ext(spr_attack_gem,0,x-1180,y-220,1.5,1.5,0,c_white,1)
}
else if info_button_select == 2{
	//绘制解锁信息
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_color(c_white);
	draw_text(x - 1220, y - 380, "等级："+string(global.save_data.player.level));
	draw_text(x - 1220, y - 320, "最大技能等级："+string(global.save_data.unlocked_items.max_skill_level));
	draw_text(x - 1220, y - 260, "卡槽数："+string(global.save_data.unlocked_items.max_slot));
	draw_text(x - 1220, y - 200, "铲子："+string(global.save_data.unlocked_items.shovel));
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_bottom);
	draw_set_font(font_yuan)
}
else if info_button_select == 3{
	//绘制解锁信息
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_color(c_white);
	if global.save_data.player.crown_version != "0.0.0"{
		draw_sprite_ext(spr_player_crown_icon,0,x-1180,y-350,1.8,1.8,0,c_white,1)
		draw_text(x - 1120, y - 350,$"你在v{global.save_data.player.crown_version}通关了全部魔塔关卡。");
	}
	else{
		draw_text(x - 1220, y - 380, "你还没有完成全部魔塔关卡。");
	}
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_bottom);
	draw_set_font(font_yuan)
}
if package_button_select == 1 {
    // 创建/重置卡片栏表面（用于裁剪溢出内容，实现滚轮翻页）
    if (!surface_exists(card_surface)) {
        card_surface = surface_create(card_surface_w, card_surface_h)
    }
    // 根据当前卡片总数计算可滚动范围，并将 y_offset 夹到合法区间
    var _total_cards = ds_list_size(global.player_deck) / 2
    var _total_rows = max(8, ceil(_total_cards / package_rows))
    var _max_offset = max(0, _total_rows * 96 - card_surface_h)
    y_offset = clamp(y_offset, 0, _max_offset)
    // 表面在屏幕上的起点（surface 内坐标 (0,0) 对应此处屏幕坐标）
    var _surf_x = x - 354 - 42
    var _surf_y = y - 359 - 48

    hover_card_index = -1 // 重置悬停卡片索引
    hover_deck_slot = -1
    drag_card_data = undefined
    drag_card_level = 0

    // 渲染卡片网格到 surface（surface 内坐标以 (42,48) 为第一格中心）
    surface_set_target(card_surface)
    draw_clear_alpha(c_black, 0)

    // 绘制背包格子背景
    for(var i = 0 ; i < package_rows ; i++){
        for(var j = 0 ; j < _total_rows ; j++){
            draw_sprite_ext(spr_package_slot_bg,0,42+i*84,48+96*j-y_offset,1.8,1.8,0,c_white,1)
        }
    }

    // 绘制所有已注册的植物卡片
    var card_index = 0
    for(var i = 0; i < ds_list_size(global.player_deck); i += 2) {
        var card_id = global.player_deck[| i]
        var deck_entry = global.player_deck[| i+1]
        var card_data_shapes = deck_entry[? "shapes"]
        var card_data = {}
        var card_shape = 0

        // 检查卡片是否已解锁
        var is_unlocked = false
        for(var k = 0; k < array_length(global.save_data.unlocked_cards); k++) {
            if (global.save_data.unlocked_cards[k].id == card_id) {
                is_unlocked = true
                card_shape = global.save_data.unlocked_cards[k].shape
                card_data = card_data_shapes[| card_shape]
                break
            }
        }

        // 未解锁的卡片直接隐藏（跳过，不占格子）
        if (!is_unlocked) {
            continue
        }

        // 计算卡片位置（surface 内坐标，仅已解锁卡片参与排版）
        var col = card_index mod package_rows
        var row = card_index div package_rows
        var _cx = 42 + col * 84
        var _cy = 48 + row * 96 - y_offset

        // 该卡片是否正处于被拖状态
        var _is_drag_source = (drag_state == 2 && drag_card_index == card_index)

        // 缓存星标等级（鼠标拖拽卡悬浮绘制时也要用）
        var length = array_length(global.save_data.unlocked_cards)
        var info_index = 0
        for (var j = 0;j < length;j++){
            if global.save_data.unlocked_cards[j].id == card_id{
                info_index = j
                break
            }
        }
        var level = global.save_data.unlocked_cards[info_index].level

        if (!_is_drag_source) {
            // 正常绘制卡片
            draw_sprite_ext(get_slot_sprite(card_data), 0, _cx, _cy-3, 0.25, 0.25, 0, c_white, 1)
            draw_sprite_ext(card_data[? "sprite"], 0, _cx, _cy+15, 0.7, 0.7, 0, c_white, 1)
            draw_set_color(c_black)
            draw_set_halign(fa_center)
            draw_set_valign(fa_bottom)
            draw_set_font(font_pixel)
            draw_text(_cx, _cy+37, card_data[? "cost"])
            draw_set_font(font_yuan)
            if level > 0{
                draw_sprite_ext(spr_star_slot, level - 1, _cx-25, _cy-35, 1.4, 1.4, 0, c_white, 1)
            }
        } else {
            // 被拖卡片：原位置留空（仅格子背景），并缓存渲染数据用于悬浮绘制
            drag_card_data = card_data
            drag_card_level = level
            // 半透明幽灵作为来源占位提示
            draw_set_alpha(0.3)
            draw_sprite_ext(get_slot_sprite(card_data), 0, _cx, _cy-3, 0.25, 0.25, 0, c_white, 1)
            draw_sprite_ext(card_data[? "sprite"], 0, _cx, _cy+15, 0.7, 0.7, 0, c_white, 1)
            draw_set_alpha(1)
        }

        // 检查鼠标是否悬停在卡片上（屏幕坐标）
        var spr_width = 84
        var spr_height = 96
        var _screen_cx = x - 354 + col * 84
        var _screen_cy = y - 359 + row * 96 - y_offset
        if (mouse_x > _surf_x && mouse_x < _surf_x + card_surface_w
            && mouse_y > _surf_y && mouse_y < _surf_y + card_surface_h){
            if (point_in_rectangle(mouse_x, mouse_y,
                _screen_cx - spr_width/2, _screen_cy - spr_height/2,
                _screen_cx + spr_width/2, _screen_cy + spr_height/2)) {
                hover_card_index = card_index
                hover_deck_slot = i div 2
            }
        }

        card_index++
    }

    surface_reset_target()
    draw_surface(card_surface, _surf_x, _surf_y)

    // 拖拽中：在鼠标位置悬浮绘制被拖卡，并在目标格上绘制高亮边框
    if (drag_state == 2 && !is_undefined(drag_card_data)) {
        // 高亮目标格
        if (hover_card_index != -1 && hover_card_index != drag_card_index && hover_deck_slot != -1) {
            var _hcol = hover_card_index mod package_rows
            var _hrow = hover_card_index div package_rows
            var _hx = x - 354 + _hcol * 84
            var _hy = y - 359 + _hrow * 96 - y_offset
            draw_set_color(c_yellow)
            draw_set_alpha(1)
            draw_rectangle(_hx - 42, _hy - 48, _hx + 42, _hy + 48, true)
            draw_set_color(c_white)
        }
        // 跟随鼠标的卡片
        draw_sprite_ext(get_slot_sprite(drag_card_data), 0, mouse_x, mouse_y-3, 0.25, 0.25, 0, c_white, 1)
        draw_sprite_ext(drag_card_data[? "sprite"], 0, mouse_x, mouse_y+15, 0.7, 0.7, 0, c_white, 1)
        draw_set_color(c_black)
        draw_set_halign(fa_center)
        draw_set_valign(fa_bottom)
        draw_set_font(font_pixel)
        draw_text(mouse_x, mouse_y+37, drag_card_data[? "cost"])
        draw_set_font(font_yuan)
        if drag_card_level > 0{
            draw_sprite_ext(spr_star_slot, drag_card_level - 1, mouse_x-25, mouse_y-35, 1.4, 1.4, 0, c_white, 1)
        }
    } else {
        // 悬停提示（拖拽中不显示以免遮挡）
        if (hover_card_index != -1) {
            // 获取鼠标位置
            var tooltip_x = mouse_x + 15
            var tooltip_y = mouse_y + 15

            var tooltip_text = "左键点击调节卡片\n长按拖动以交换位置\n右键点击查看情报"

            // 绘制提示背景
            draw_set_color(c_black)
            draw_set_alpha(0.7)
            draw_rectangle(tooltip_x - 5, tooltip_y - 5,
                          tooltip_x + string_width(tooltip_text)+5, tooltip_y + string_height(tooltip_text)+5, false)

            // 绘制提示文本
            draw_set_halign(fa_left)
            draw_set_valign(fa_top)
            draw_set_alpha(1)
            draw_set_color(c_white)
            draw_text(tooltip_x, tooltip_y, tooltip_text)
        }
    }
}
else if package_button_select == 2 {
    // 武器栏表面（裁剪溢出 + 滚轮）
    if (!surface_exists(weapon_surface)) {
        weapon_surface = surface_create(weapon_surface_w, weapon_surface_h)
    }
    var _surf_x = x - 354 - 42
    var _surf_y = y - 359 - 48
    var _gw = package_rows

    // 预先统计总行数用于限位
    var _est = array_length(global.save_data.unlocked_weapons) + array_length(global.save_data.unlocked_gems)
    var _total_rows = max(8, ceil(_est / _gw) + 4)
    var _max_offset = max(0, _total_rows * 88 - weapon_surface_h)
    weapon_y_offset = clamp(weapon_y_offset, 0, _max_offset)

    hover_weapon_index = -1
    hover_gem_index = -1

    surface_set_target(weapon_surface)
    draw_clear_alpha(c_black, 0)

    var weapon_index = 0

    // ===== 普通武器 =====
    for(var i = 0; i < array_length(global.save_data.unlocked_weapons); i++){
        var _wid = global.save_data.unlocked_weapons[i].id
        var _wdata = global.weapon_pool[? _wid]
        if (is_undefined(_wdata) || is_weapon_exclusive(_wid)) continue

        var _col = weapon_index mod _gw
        var _row = weapon_index div _gw
        var _cx = 42 + _col * 84
        var _cy = 48 + _row * 88 - weapon_y_offset
        var _eq = is_weapon_equipped(_wid)
        draw_sprite_ext(spr_package_slot_bg,1,_cx,_cy,1.8,1.8,0,_eq?c_yellow:c_white,1)
        draw_sprite_ext(_wdata.icon,0,_cx,_cy,1,1,0,c_white,1)
        if (point_in_rectangle(mouse_x,mouse_y,_surf_x+_cx-42,_surf_y+_cy-44,_surf_x+_cx+42,_surf_y+_cy+44)){
            hover_weapon_index = i
        }
        weapon_index++
    }

    // ===== 换行 =====
    weapon_index = ceil(weapon_index / _gw) * _gw

    // ===== 普通宝石 =====
    for(var i = 0; i < array_length(global.save_data.unlocked_gems); i++){
        var _gid = global.save_data.unlocked_gems[i].id
        var _gdata = get_gem_info(_gid)
        if (is_undefined(_gdata) || is_gem_exclusive(_gid)) continue

        var _col = weapon_index mod _gw
        var _row = weapon_index div _gw
        var _cx = 42 + _col * 84
        var _cy = 48 + _row * 88 - weapon_y_offset
        var _eq = (get_gem_index(_gid) != -1)
        draw_sprite_ext(spr_package_slot_bg,1,_cx,_cy,1.8,1.8,0,_eq?c_yellow:c_white,1)
        draw_sprite_ext(_gdata.icon,0,_cx,_cy,1.4,1.4,0,c_white,1)
        if (get_gem_level(_gid) > 0){
            draw_sprite_ext(spr_star_slot,get_gem_level(_gid)-1,_cx-28,_cy-30,1.4,1.4,0,c_white,1)
        }
        if (point_in_rectangle(mouse_x,mouse_y,_surf_x+_cx-42,_surf_y+_cy-44,_surf_x+_cx+42,_surf_y+_cy+44)){
            hover_gem_index = i
        }
        weapon_index++
    }

    // ===== 专属武器（每个独占一行，宝石跟在同一行） =====
    for(var i = 0; i < array_length(global.save_data.unlocked_weapons); i++){
        var _wid = global.save_data.unlocked_weapons[i].id
        var _wdata = global.weapon_pool[? _wid]
        if (is_undefined(_wdata) || !is_weapon_exclusive(_wid)) continue

        weapon_index = ceil(weapon_index / _gw) * _gw  // 独占新行
        var _row = weapon_index div _gw
        var _col = weapon_index mod _gw
        var _cx = 42 + _col * 84
        var _cy = 48 + _row * 88 - weapon_y_offset
        var _eq = is_weapon_equipped(_wid)
        draw_sprite_ext(spr_package_slot_bg,1,_cx,_cy,1.8,1.8,0,_eq?c_yellow:c_white,1)
        draw_sprite_ext(_wdata.icon,0,_cx,_cy,1,1,0,c_white,1)
        if (point_in_rectangle(mouse_x,mouse_y,_surf_x+_cx-42,_surf_y+_cy-44,_surf_x+_cx+42,_surf_y+_cy+44)){
            hover_weapon_index = i
        }
        weapon_index++

        // 该武器的专属宝石
        for(var j = 0; j < array_length(global.save_data.unlocked_gems); j++){
            var _gid = global.save_data.unlocked_gems[j].id
            var _gdata = get_gem_info(_gid)
            if (is_undefined(_gdata)) continue
            if (!is_gem_exclusive(_gid) || _gdata.exclusive_for != _wid) continue

            var _col2 = weapon_index mod _gw
            var _row2 = weapon_index div _gw
            var _cx2 = 42 + _col2 * 84
            var _cy2 = 48 + _row2 * 88 - weapon_y_offset
            var _eq2 = (get_gem_index(_gid) != -1)
            draw_sprite_ext(spr_package_slot_bg,1,_cx2,_cy2,1.8,1.8,0,_eq2?c_yellow:c_white,1)
            draw_sprite_ext(_gdata.icon,0,_cx2,_cy2,1.4,1.4,0,c_white,1)
            if (get_gem_level(_gid) > 0){
                draw_sprite_ext(spr_star_slot,get_gem_level(_gid)-1,_cx2-28,_cy2-30,1.4,1.4,0,c_white,1)
            }
            if (point_in_rectangle(mouse_x,mouse_y,_surf_x+_cx2-42,_surf_y+_cy2-44,_surf_x+_cx2+42,_surf_y+_cy2+44)){
                hover_gem_index = j
            }
            weapon_index++
        }
    }

    surface_reset_target()
    draw_surface(weapon_surface, _surf_x, _surf_y)

    // 绘制悬停提示
    if (hover_weapon_index != -1) {
        var weapon_id = global.save_data.unlocked_weapons[hover_weapon_index].id;
        var weapon_data = global.weapon_pool[? weapon_id];
        
        if (!is_undefined(weapon_data)) {
            // 获取鼠标位置
            var tooltip_x = mouse_x - 15;
            var tooltip_y = mouse_y - 15;
            
			// 获取提示文本
            
            var tooltip_text = ""
            var is_equipped = is_weapon_equipped(weapon_id);
            if (is_equipped) {
                var slot = get_weapon_slot(weapon_id);
                tooltip_text = weapon_data.description + "\n已装备\n左键点击卸下"
            } else {
                tooltip_text = weapon_data.description + "\n左键点击装备"
            }
			
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
			draw_text(tooltip_x- string_width(tooltip_text), tooltip_y, tooltip_text);
			
            
        }
    }
    if (hover_gem_index != -1) {
        var weapon_id = global.save_data.unlocked_gems[hover_gem_index].id;
        var weapon_data = get_gem_info(weapon_id)
        
        if (!is_undefined(weapon_data)) {
            // 获取鼠标位置
            var tooltip_x = mouse_x - 15;
            var tooltip_y = mouse_y - 15;
            
			// 获取提示文本
            
            var tooltip_text = ""
            var is_equipped = (get_gem_index(weapon_id) != -1)
            if (is_equipped) {
                //var slot = get_weapon_slot(weapon_id);
                tooltip_text = weapon_data.description + "\n左键点击卸下\n右键点击编辑"
            } else {
                tooltip_text = weapon_data.description + "\n左键点击镶嵌\n右键点击编辑"
            }
			
            // 绘制提示背景
            draw_set_color(c_black);
            draw_set_alpha(0.7);
            draw_rectangle(tooltip_x - string_width(tooltip_text)- 5, tooltip_y - 5, 
                          tooltip_x +5, tooltip_y + string_height(tooltip_text)+5, false);
			//绘制提示文本
			draw_set_halign(fa_left);
            draw_set_valign(fa_top);
            draw_set_alpha(1);
            draw_set_color(c_white);
			draw_text(tooltip_x- string_width(tooltip_text), tooltip_y, tooltip_text);
			
            
        }
    }
	

}
else if package_button_select == 3{
	// 绘制道具背包
    for(var i = 0 ; i < package_rows ; i++){
        for(var j = 0 ; j < package_cols ; j++){
            draw_sprite_ext(spr_package_slot_bg,1,x-354+i*84,y - 368 + 88 * j,1.8,1.8,0,c_white,1)
        }
    }
	// 绘制所有道具
    var material_index = 0;
    hover_material_index = -1; // 重置悬停道具索引
	var material_list = ds_map_keys_to_array(global.material_pool)
    
    for(var i = 0; i < array_length(material_list); i++) {
        var material_id = material_list[i]
        var material_data = get_material_info(material_id)
        
        if (!is_undefined(material_data)) {
            // 计算道具位置
            var row = material_data.pos_y;
            var col = material_data.pos_x;
            
            if (row < package_rows) {
                var material_x = x - 354 + col * 84;
                var material_y = y - 368 + row * 88;
                               
                //draw_sprite_ext(spr_package_slot_bg, 1, weapon_x, weapon_y, 1.8, 1.8, 0, c_white, 1);
                draw_sprite_ext(spr_craft_material,material_data.icon, material_x, material_y, 1.8, 1.8, 0, c_white, 1);
				draw_set_halign(fa_right);
				draw_set_valign(fa_bottom);
				draw_set_colour(c_white)
				draw_set_font(font_number)
				if get_material_amount(material_id) < 10000{
					draw_text(material_x+40,material_y+42,string(get_material_amount(material_id)))
				}
				else{
					draw_text(material_x+40,material_y+42,string(floor(get_material_amount(material_id)/10000))+"w")
				}
                
                // 检查鼠标是否悬停在道具上
                var spr_width = 84;
                var spr_height = 88;
                
                if (point_in_rectangle(mouse_x, mouse_y, 
                                      material_x - spr_width/2, material_y - spr_height/2,
                                      material_x + spr_width/2, material_y + spr_height/2)) {
                    hover_material_index = i;
                }
                
                material_index++;
            }
        }
    }
	// 绘制悬停提示
    if (hover_material_index != -1) {
		var material_list = ds_map_keys_to_array(global.material_pool)
        var material_id = material_list[hover_material_index]
        var material_data = get_material_info(material_id)
        
        if (!is_undefined(material_data)) {
            // 获取鼠标位置
            var tooltip_x = mouse_x - 15;
            var tooltip_y = mouse_y - 15;
            
			// 获取提示文本
            
            var tooltip_text = ""
            
			tooltip_text = material_data.description + "\n数量："+string(get_material_amount(material_id))
            
			
            // 绘制提示背景
			draw_set_font(font_yuan)
            draw_set_color(c_black);
            draw_set_alpha(0.7);
            draw_rectangle(tooltip_x - string_width(tooltip_text) - 5, tooltip_y - 5, 
                          tooltip_x +5, tooltip_y + string_height(tooltip_text)+5, false);
			//绘制提示文本
			draw_set_halign(fa_left);
            draw_set_valign(fa_top);
            draw_set_alpha(1);
            draw_set_color(c_white);
			draw_text(tooltip_x- string_width(tooltip_text), tooltip_y, tooltip_text);
			
            
        }
    }
}

// 重置绘制设置
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);