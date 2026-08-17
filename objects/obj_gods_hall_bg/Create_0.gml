image_xscale = 1.6
image_yscale = 1.6

instance_create_depth(1473, 284, depth-1,obj_gods_hall_closer)
instance_create_depth(1296, 284, depth-1,obj_gods_store_enter)

is_submenu_opened = false
is_wishing = false
wish_completed = true
wish_round = 0
start_wishing8 = false
reward_id = []
reward_list = []

var wish8 = instance_create_depth(x+2, 782, depth-1,obj_gods_hall_wish)
wish8.parent_gui = id;

// 8个宝箱，上四下四
var _rows = [room_height/2 - 135, room_height/2 + 40]
var _cols = [x+2 - 330, x+2 - 110, x+2 + 110, x+2 + 330]
var _bag_num = 0
for (var _r = 0; _r < 2; _r++){
	for (var _c = 0; _c < 4; _c++){
		var bag = instance_create_depth(_cols[_c], _rows[_r], depth-1, obj_gods_hall_bag)
		bag.parent_gui = id;
		bag.list_num = _bag_num;
		_bag_num++;
	}
}

function gods_hall_get_random_reward() {
	
	var r = irandom(999); // 0~999

	if (r < 100) return ["金币", 20000];      // 10%
	else if (r < 180) return ["金币", 50000]; // 8%
	else if (r < 200) return ["金币", 200000];// 2%
	else if (r < 320) return ["天然香料", 100]; // 12%
	else if (r < 400) return ["秘制香料", 50]; // 8%
	else if (r < 460) return ["皇室香料", 20];// 6%
	else if (r < 490) return ["魔幻香料", 10];// 3%
	else if (r < 498) return ["精灵香料", 5];// 0.8%
	else if (r < 500) return ["圣灵香料", 5];// 0.2%
	else if (r < 550) return ["1级四叶草", 10];// 5%
	else if (r < 600) return ["2级四叶草", 5];// 5%
	else if (r < 670) return ["3级四叶草", 2];// 7%
	else if (r < 790) return ["4级四叶草", 1];// 12%
	else if (r < 880) return ["5级四叶草", 1];// 9%
	else if (r < 940) return ["6级四叶草", 1];// 6%
	else if (r < 970) return ["S级四叶草", 1];// 3%
	else if (r < 982) return ["SS四叶草", 1];// 1.2%
	else if (r < 988) return ["SSS四叶草", 1];// 0.6%
	else if (r < 990) return ["SSR四叶草", 1];// 0.2%
	else if (r < 998) return ["神谕之石", 2];// 0.8%
	else  return ["神谕之石", 5];// 0.2%	
}

// 小保底
function gods_hall_get_small_pity_reward() {
	
	var r = irandom(99);

	if (r < 10) return ["精灵香料", 10]; // 10%
	else if (r < 20) return ["圣灵香料", 5];// 10%
	else if (r < 30) return ["SSS四叶草", 1];// 10%
	else if (r < 40) return ["SSR四叶草", 1];// 10%
	else if (r < 80) return ["神谕之石", 5];// 40%
	else if (r < 90) return ["神谕之石", 10];// 15%
	else return ["神谕之石", 20];            // 5%
}

// 大保底
function gods_hall_get_big_pity_reward() {
	
	var r = irandom(99);

	if (r < 60) return ["神谕之石", 20]; // 60%
	else if (r < 80) return ["神谕之石", 25];// 20%
	else return ["神谕之石", 30];            // 20%
}