function gods_goods_registry_init(){
	global.gods_goods_map = ds_map_create()
}

function register_gods_goods(goods_id,data){
	global.gods_goods_map[? goods_id] = data
}