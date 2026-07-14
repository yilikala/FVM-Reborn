clevel = get_card_info_simple(card_id).level
cshape = get_card_info_simple(card_id).shape
//cskill = get_card_info_simple(card_id).skill
var plant_data = get_plant_data(card_id);
if (plant_data != undefined) {
	
	var card_save_data = get_card_info(card_id)
	clevel = card_save_data.level
	cshape = card_save_data.shape
	cskill = card_save_data.skill
    
    // 应用基础属性
    var upgrade_data = get_plant_data_with_skill(card_id, cshape,clevel,cskill);
    if (upgrade_data != undefined) {
        cost = upgrade_data[? "cost"];
        cooldown = upgrade_data[? "cooldown"];
    }
	
}
info_got = true