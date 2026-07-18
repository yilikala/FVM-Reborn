image_xscale = 0.9
image_yscale = 0.9

is_submenu_opened = false
button_select = 0

instance_create_depth(x+785,y-466,depth-1,obj_closecraft_btn)
instance_create_depth(x-305,y+220,depth-1,obj_craft_confirm_btn)

var btn1 = instance_create_depth(x-661,y-50,depth-1,obj_craft_select_btn)
btn1.button_index = 0
btn1.text_spr = spr_craft_card_text
var btn2 = instance_create_depth(x-661,y+100,depth-1,obj_craft_select_btn)
btn2.button_index = 1
btn2.text_spr = spr_craft_gem_text
var btn3 = instance_create_depth(x-661,y+250,depth-1,obj_craft_select_btn)
btn3.button_index = 2
btn3.text_spr = spr_craft_synthesize_text

card_material_id_list = ["natural_spices","secret_spices","royal_spices","magical_spices","elven_spices","angelic_spices","clover_1","clover_2","clover_3","clover_4","clover_5","clover_6","clover_S","clover_SS","clover_SSS","clover_SSR"]
gem_material_id_list = ["less_crystal","middle_crystal","advanced_crystal","clover_1","clover_2","clover_3","clover_4","clover_5","clover_6","clover_S","clover_SS","clover_SSS","clover_SSR"]
spice_synthesis_material_id_list = ["natural_spices","secret_spices","royal_spices","magical_spices","elven_spices","clover_1","clover_2","clover_3","clover_4","clover_5","clover_6","clover_S","clover_SS","clover_SSS","clover_SSR"]


hover_card_index = -1
hover_gem_index = -1
close_timer = -1

y_offset = 0
card_surface = -1

current_uprade_target_id = ""

spices_use_order = ["natural_spices","secret_spices","royal_spices","magical_spices","elven_spices","angelic_spices"]
clover_use_order = ["clover_1","clover_2","clover_3","clover_4","clover_5","clover_6","clover_S","clover_SS","clover_SSS","clover_SSR"]
crystal_use_order = ["less_crystal","middle_crystal","advanced_crystal"]

// 当前强化投入状态
input_spice_id = ""        // 当前选定的香料类型（必须与配方要求一致）
input_spice_count = 0      // 玩家投入的香料数量
input_spice_base = 0       // 基础消耗量（4倍为上限）
input_spice_max = 0        // 香料投入上限（= 4 * base）
input_crystal_id = ""      // 当前选定的水晶类型（宝石强化用，不累加）
input_crystal_count = 0    // 水晶消耗数量（= 基础量，固定）
input_crystal_max = 0      // 水晶消耗上限（= 基础量）
input_clover_id = ""       // 当前选定的四叶草类型（空表示未投入，仅1个）
insured = false            // 是否启用保险金
hover_material_index = -1  // 鼠标悬停的材料序号
hover_switch_arrow = false // 鼠标悬停在切换箭头
hover_insurance_box = false// 鼠标悬停在保险勾选框
material_page = 0          // 材料栏当前页
material_per_page = 11     // 材料栏每页可显示的格数

// 香料合成投入状态（button_select == 2）
syn_input_spice_id = ""    // 当前作为原料的低级香料
syn_input_clover_id = ""   // 当前选定的四叶草
syn_last_spice_id = ""     // 上一次合成使用的香料（用于自动重填）
syn_last_clover_id = ""    // 上一次合成使用的四叶草