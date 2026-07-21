var reward_id = parent_gui.reward_list[list_num]
var reward_spr = 0
switch(reward_id[0]){
	case "金币": reward_spr = 0;break;
	case "神谕之石": reward_spr = 1;break;
	case "天然香料": reward_spr = 2;break;
	case "秘制香料": reward_spr = 3;break;
	case "皇室香料": reward_spr = 4;break;
	case "魔幻香料": reward_spr = 5;break;
	case "精灵香料": reward_spr = 6;break;
	case "圣灵香料": reward_spr = 7;break;
	case "1级四叶草": reward_spr = 8;break;
	case "2级四叶草": reward_spr = 9;break;
	case "3级四叶草": reward_spr = 10;break;
	case "4级四叶草": reward_spr = 11;break;
	case "5级四叶草": reward_spr = 12;break;
	case "6级四叶草": reward_spr = 13;break;
	case "S级四叶草": reward_spr = 14;break;
	case "SS四叶草": reward_spr = 15;break;
	case "SSS四叶草": reward_spr = 16;break;
	case "SSR四叶草": reward_spr = 17;break;
}

var reward = instance_create_depth(x-2, y-20, depth-1,obj_gods_hall_reward)
reward.parent_gui = id;
reward.list_num = list_num;
reward.reward_id = reward_id;
reward.image_index = reward_spr;

if reward_id[0] == "神谕之石" || reward_id[0] == "精灵香料" || reward_id[0] == "圣灵香料" || reward_id[0] == "SSS四叶草" || reward_id[0] == "SSR四叶草"{
	var effect = instance_create_depth(x-1, y-20, depth-1,obj_gods_hall_reward_effect)
	effect.parent_gui = reward
}