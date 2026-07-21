function material_init(){
	material_registry_init()
	register_material("natural_spices",{"name":"天然香料",
										"description":"天然香料：强化1~4星卡片所需材料",
										"icon":0,
										"pos_x":0,
										"pos_y":0})
	register_material("secret_spices",{"name":"秘制香料",
										"description":"秘制香料：强化5~7星卡片所需材料",
										"icon":1,
										"pos_x":1,
										"pos_y":0})
	register_material("royal_spices",{"name":"皇室香料",
										"description":"皇室香料：强化8~10星卡片所需材料",
										"icon":2,
										"pos_x":2,
										"pos_y":0})
	register_material("magical_spices",{"name":"魔幻香料",
										"description":"魔幻香料：强化11~12星卡片所需材料",
										"icon":3,
										"pos_x":3,
										"pos_y":0}) //
	register_material("elven_spices",{"name":"精灵香料",
										"description":"精灵香料：强化13~14星卡片所需材料",
										"icon":4,
										"pos_x":4,
										"pos_y":0}) //
	register_material("holyspirit_spices",{"name":"圣灵香料",
										"description":"圣灵香料：强化15~16星卡片所需材料",
										"icon":5,
										"pos_x":5,
										"pos_y":0}) //
	register_material("clover_1",{"name":"1级四叶草",
										"description":"1级四叶草：提升强化概率至1.2倍",
										"icon":6,
										"pos_x":0,
										"pos_y":1})
	register_material("clover_2",{"name":"2级四叶草",
										"description":"2级四叶草：提升强化概率至1.4倍",
										"icon":7,
										"pos_x":1,
										"pos_y":1})
	register_material("clover_3",{"name":"3级四叶草",
										"description":"3级四叶草：提升强化概率至1.7倍",
										"icon":8,
										"pos_x":2,
										"pos_y":1})
	register_material("clover_4",{"name":"4级四叶草",
										"description":"4级四叶草：提升强化概率至2倍",
										"icon":9,
										"pos_x":3,
										"pos_y":1}) //
	register_material("clover_5",{"name":"5级四叶草",
										"description":"5级四叶草：提升强化概率至2.4倍",
										"icon":10,
										"pos_x":4,
										"pos_y":1}) //
	register_material("clover_6",{"name":"6级四叶草",
										"description":"6级四叶草：提升强化概率至2.7倍",
										"icon":11,
										"pos_x":5,
										"pos_y":1}) //
	register_material("clover_S",{"name":"S级四叶草",
										"description":"S级四叶草：提升强化概率至3倍",
										"icon":12,
										"pos_x":6,
										"pos_y":1}) //
	register_material("clover_SS",{"name":"SS四叶草",
										"description":"SS四叶草：提升强化概率至3.3倍",
										"icon":13,
										"pos_x":7,
										"pos_y":1}) //
	register_material("clover_SSS",{"name":"SSS四叶草",
										"description":"SSS四叶草：提升强化概率至3.6倍",
										"icon":14,
										"pos_x":0,
										"pos_y":2}) //
	register_material("clover_SSR",{"name":"SSR四叶草",
										"description":"SSR四叶草：提升强化概率至4倍",
										"icon":15,
										"pos_x":1,
										"pos_y":2}) //
	register_material("less_crystal",{"name":"初级强化水晶",
										"description":"初级强化水晶：强化1~5星宝石所需材料",
										"icon":16,
										"pos_x":0,
										"pos_y":3})
	register_material("middle_crystal",{"name":"中级强化水晶",
										"description":"中级强化水晶：强化6~10星宝石所需材料",
										"icon":17,
										"pos_x":1,
										"pos_y":3})
	register_material("advanced_crystal",{"name":"高级强化水晶",
										"description":"高级强化水晶：强化11~15星宝石所需材料",
										"icon":18,
										"pos_x":2,
										"pos_y":3})
}