if (global.debug && plant_id!="player"){
	show_debug_message(string(plant_id) + "当前atk: " + string(atk));
	show_debug_message(string(plant_id) + "当前cyc: " + string(cycle));
	if variable_instance_exists(self.id, "buff_value") {
		show_debug_message(string(plant_id) + "当前buf: " + string(buff_value));
	}
}
