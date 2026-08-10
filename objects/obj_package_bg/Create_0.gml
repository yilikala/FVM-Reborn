image_xscale = 1.8
image_yscale = 1.8
instance_create_depth(x+380,y+403,depth-1,obj_closepackage_btn)
package_cols = 8 //背包格子行列数
package_rows = 9
info_button_select = 1
package_button_select = 1
is_submenu_opened = false
gem_start_line = 0
//创建背包栏位选择按钮
var btn1 = instance_create_depth(x-300,y-455,depth-1,obj_packageselect_btn)
btn1.type = "Package"
btn1.button_index = 1
btn1.sprite_index = spr_packageselect_btn_1
var btn2 = instance_create_depth(x-70,y-455,depth-1,obj_packageselect_btn)
btn2.type = "Package"
btn2.button_index = 2
btn2.sprite_index = spr_packageselect_btn_2
var btn5 = instance_create_depth(x+160,y-455,depth-1,obj_packageselect_btn)
btn5.type = "Package"
btn5.button_index = 3
btn5.sprite_index = spr_packageselect_btn_5
var btn3 = instance_create_depth(x-1170,y-454,depth-1,obj_packageselect_btn)
btn3.type = "Player Info"
btn3.button_index = 1
btn3.sprite_index = spr_packageselect_btn_3
var btn4 = instance_create_depth(x-1020,y-454,depth-1,obj_packageselect_btn)
btn4.type = "Player Info"
btn4.button_index = 2
btn4.sprite_index = spr_packageselect_btn_4
var btn6 = instance_create_depth(x-870,y-454,depth-1,obj_packageselect_btn)
btn6.type = "Player Info"
btn6.button_index = 3
btn6.sprite_index = spr_packageselect_btn_6

hover_card_index = -1; // 当前悬停的卡片索引（仅已解锁卡，紧凑排序）
hover_weapon_index = -1
hover_gem_index = -1
hover_material_index = -1
hover_deck_slot = -1 // 被悬停卡在 player_deck 中的条目位置（i/2，传递给子菜单用）
view_max_shapes = 0

// 卡片栏滚动相关
y_offset = 0
card_surface = -1
card_surface_w = 768
card_surface_h = 815

// 武器栏滚动相关
weapon_y_offset = 0
weapon_surface = -1
weapon_surface_w = 768
weapon_surface_h = 815

// 卡片栏拖拽相关
drag_state = 0 // 0=空闲 1=按下中 2=拖拽中
drag_hold_timer = 0
drag_start_x = 0
drag_start_y = 0
drag_card_index = -1 // 被拖卡片的 hover_card_index 值
drag_deck_slot = -1 // 被拖卡片的 player_deck 条目位置
// 被拖卡片的渲染数据（每帧在 Draw 中刷新一次供悬浮绘制用）
drag_card_data = undefined
drag_card_level = 0