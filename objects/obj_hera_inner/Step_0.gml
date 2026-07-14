if global.is_paused{
	exit
}
if !instance_exists(parent_plant){
	instance_destroy()
	exit
}
image_index = parent_plant.image_index
depth = calculate_plant_depth(parent_plant.grid_col, parent_plant.grid_row, "shield_inner")
