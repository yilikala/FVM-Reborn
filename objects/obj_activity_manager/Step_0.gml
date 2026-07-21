if !instance_exists(obj_gods_hall_enter) {
	if room == room_map || room == room_menu{
		instance_create_depth(750, 62, -3, obj_gods_hall_enter) // 诸神宝殿
	}
}
if !instance_exists(obj_exchange_menu_entrance) {
	if room == room_map || room == room_menu{
		instance_create_depth(850, 62, -3, obj_exchange_menu_entrance) // 兑换所
	}
}