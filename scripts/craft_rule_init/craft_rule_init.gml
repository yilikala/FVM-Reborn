function craft_rule_registry_init(){
	global.card_craft_rules = ds_map_create()
	global.gem_craft_rules = ds_map_create()
}

function register_card_craft_rule(target_level,info){
	ds_map_add(global.card_craft_rules,target_level,info)
}

function get_card_craft_rule(target_level){
	return ds_map_find_value(global.card_craft_rules,target_level)
}

function register_gem_craft_rule(target_level,info){
	ds_map_add(global.gem_craft_rules,target_level,info)
}

function get_gem_craft_rule(target_level){
	return ds_map_find_value(global.gem_craft_rules,target_level)
}

function get_clover_tier(clover_id){
	var tiers = {
		"clover_1":1, "clover_2":2, "clover_3":3,
		"clover_4":4, "clover_5":5, "clover_6":6,
		"clover_S":7, "clover_SS":8, "clover_SSS":9, "clover_SSR":10
	}
	if variable_struct_exists(tiers, clover_id){
		return tiers[$ clover_id]
	}
	return 0
}

function spice_synthesis_registry_init(){
	global.spice_synthesis_rules = ds_map_create()
}
function register_spice_synthesis_rule(input_id, info){
	ds_map_add(global.spice_synthesis_rules, input_id, info)
}
function get_spice_synthesis_rule(input_id){
	return ds_map_find_value(global.spice_synthesis_rules, input_id)
}
function get_spice_synthesis_base_rate(input_id){
	var rule = get_spice_synthesis_rule(input_id)
	if is_undefined(rule) { return 0 }
	return rule.base_rate
}
// 香料成功率
function calc_synthesis_rate(base_rate, clover_count){
	var rates = {
		"0":1.00,
		"1":1.20, "2":1.40, "3":1.70, "4":2.00, "5":2.40,
		"6":2.70, "7":3.00, "8":3.30, "9":3.60, "10":4.00,
	}
	var rate = base_rate * rates[$ string(clover_count)]
	if rate > 1.0 { rate = 1.0 }
	if rate < 0.0 { rate = 0.0 }
	return rate
}

// 卡片成功率
function get_card_base_rate(target_level){
	var rates = {
		"1":1.00, "2":0.90, "3":0.80, "4":0.70, "5":0.60,
		"6":0.50, "7":0.40, "8":0.32, "9":0.25, "10":0.18,
		"11":0.14, "12":0.12, "13":0.10, "14":0.09, "15":0.08, "16":0.05
	}
	if variable_struct_exists(rates, string(target_level)){
		return rates[$ string(target_level)]
	}
	return 1.0
}

// 卡片保险金
function get_insurance_cost(target_level){
	var insurance = {
		"1":5, "2":10, "3":20, "4":30, "5":50,
		"6":100, "7":180, "8":300, "9":450, "10":1000,
		"11":3000, "12":7000, "13":15000, "14":25000, "15":40000, "16":65000
	}
	if variable_struct_exists(insurance, string(target_level)){
		return insurance[$ string(target_level)]
	}
}

// 宝石成功率
function get_gem_base_rate(target_level){
	var rates = {
		"1":1.00, "2":0.88, "3":0.78, "4":0.68, "5":0.60,
		"6":0.52, "7":0.44, "8":0.36, "9":0.29, "10":0.22,
		"11":0.19, "12":0.16, "13":0.13, "14":0.11, "15":0.09
	}
	if variable_struct_exists(rates, string(target_level)){
		return rates[$ string(target_level)]
	}
	return 1.0
}

// 计算强化最终成功率
function calc_reinforce_rate(base_rate, spice_count, spice_base, clover_count){
	if spice_base <= 0 { return 0 }
	var spice_mult = sqrt(spice_count / spice_base)
	var rates = {
		"0":1.00,
		"1":1.20, "2":1.40, "3":1.70, "4":2.00, "5":2.40,
		"6":2.70, "7":3.00, "8":3.30, "9":3.60, "10":4.00,
	}
	var rate = base_rate * spice_mult * rates[$ string(clover_count)]
	if rate > 1.0 { rate = 1.0 }
	if rate < 0.0 { rate = 0.0 }
	return rate
}

function craft_rule_init(){
	craft_rule_registry_init()
	register_card_craft_rule("1", {"spices_require":"natural_spices","spices_amount":5,"gold_amount":300})
	register_card_craft_rule("2", {"spices_require":"natural_spices","spices_amount":10,"gold_amount":500})
	register_card_craft_rule("3", {"spices_require":"natural_spices","spices_amount":15,"gold_amount":800})
	register_card_craft_rule("4", {"spices_require":"natural_spices","spices_amount":25,"gold_amount":1200})
	register_card_craft_rule("5", {"spices_require":"secret_spices", "spices_amount":5,"gold_amount":2000})
	register_card_craft_rule("6", {"spices_require":"secret_spices", "spices_amount":10,"gold_amount":3000})
	register_card_craft_rule("7", {"spices_require":"secret_spices", "spices_amount":15,"gold_amount":4000})
	register_card_craft_rule("8", {"spices_require":"secret_spices", "spices_amount":25,"gold_amount":5000})
	register_card_craft_rule("9", {"spices_require":"royal_spices",  "spices_amount":5,"gold_amount":7000})
	register_card_craft_rule("10",{"spices_require":"royal_spices",  "spices_amount":10,"gold_amount":8000})
	register_card_craft_rule("11", {"spices_require":"magical_spices","spices_amount":5,"gold_amount":10000})
	register_card_craft_rule("12", {"spices_require":"magical_spices","spices_amount":15,"gold_amount":12000})
	register_card_craft_rule("13", {"spices_require":"elven_spices",  "spices_amount":5,"gold_amount":15000})
	register_card_craft_rule("14", {"spices_require":"elven_spices",  "spices_amount":15,"gold_amount":20000})
	register_card_craft_rule("15", {"spices_require":"holyspirit_spices","spices_amount":5,"gold_amount":30000})
	register_card_craft_rule("16", {"spices_require":"holyspirit_spices","spices_amount":20,"gold_amount":50000})
	
	
	register_gem_craft_rule(
		"1",
		{
		"crystal_require":"less_crystal",
		"crystal_amount":5,
		"gold_amount":300
		}
	)
	register_gem_craft_rule(
		"2",
		{
		"crystal_require":"less_crystal",
		"crystal_amount":10,
		"gold_amount":500
		}
	)
	register_gem_craft_rule(
		"3",
		{
		"crystal_require":"less_crystal",
		"crystal_amount":15,
		"gold_amount":800
		}
	)
	register_gem_craft_rule(
		"4",
		{
		"crystal_require":"less_crystal",
		"crystal_amount":25,
		"gold_amount":1200
		}
	)
	register_gem_craft_rule(
		"5",
		{
		"crystal_require":"less_crystal",
		"crystal_amount":40,
		"gold_amount":1500
		}
	)
	register_gem_craft_rule(
		"6",
		{
		"crystal_require":"middle_crystal",
		"crystal_amount":10,
		"gold_amount":2000
		}
	)
	register_gem_craft_rule(
		"7",
		{
		"crystal_require":"middle_crystal",
		"crystal_amount":15,
		"gold_amount":3000
		}
	)
	register_gem_craft_rule(
		"8",
		{
		"crystal_require":"middle_crystal",
		"crystal_amount":20,
		"gold_amount":4000
		}
	)
	register_gem_craft_rule(
		"9",
		{
		"crystal_require":"middle_crystal",
		"crystal_amount":30,
		"gold_amount":6000
		}
	)
	register_gem_craft_rule(
		"10",
		{
		"crystal_require":"middle_crystal",
		"crystal_amount":50,
		"gold_amount":8000
		}
	)
	register_gem_craft_rule(
		"11",
		{
		"crystal_require":"advanced_crystal",
		"crystal_amount":10,
		"gold_amount":10000
		}
	)
	register_gem_craft_rule(
		"12",
		{
		"crystal_require":"advanced_crystal",
		"crystal_amount":20,
		"gold_amount":15000
		}
	)
	register_gem_craft_rule(
		"13",
		{
		"crystal_require":"advanced_crystal",
		"crystal_amount":30,
		"gold_amount":20000
		}
	)
	register_gem_craft_rule(
		"14",
		{
		"crystal_require":"advanced_crystal",
		"crystal_amount":40,
		"gold_amount":30000
		}
	)
	register_gem_craft_rule(
		"15",
		{
		"crystal_require":"advanced_crystal",
		"crystal_amount":60,
		"gold_amount":50000
		}
	)

	// 香料合成
	spice_synthesis_registry_init()
	register_spice_synthesis_rule("natural_spices",{"output_id":"secret_spices","required":20,"base_rate":0.55,"insurance":50,"gold_amount":500})
	register_spice_synthesis_rule("secret_spices", {"output_id":"royal_spices",  "required":20,"base_rate":0.45,"insurance":100,"gold_amount":1000})
	register_spice_synthesis_rule("royal_spices",  {"output_id":"magical_spices","required":15,"base_rate":0.35,"insurance":250,"gold_amount":2000})
	register_spice_synthesis_rule("magical_spices",{"output_id":"elven_spices",  "required":15,"base_rate":0.30,"insurance":800,"gold_amount":5000})
	register_spice_synthesis_rule("elven_spices",  {"output_id":"holyspirit_spices","required":10,"base_rate":0.20,"insurance":4000,"gold_amount":10000})
}