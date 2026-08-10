image_xscale = 1.6
image_yscale = 1.6
image_speed = 0
parent_player = noone
atk = 0
cycle = 0
grid_col = 0
grid_row = 0
flash_speed = 6
attack_anim = 6
timer = 0
state = CARD_STATE.IDLE;
attack_timer = 0
weapon_id = "zeus_bolt"
weapon_info = get_weapon_info(weapon_id)
atk = weapon_info.atk
cycle = weapon_info.cycle

bullet_count = 2
bullet_style = 0;
splash_ratio = 0

fire_count = 0;
fire_cd = 25;

if get_gem_index("zeus_bolt_gem_1")!= -1{
	bullet_style = weapon_info.bullet_style_impact[get_gem_level("zeus_bolt_gem_1")]
	splash_ratio = (weapon_info.splash_ratio_impact[get_gem_level("zeus_bolt_gem_1")])/100
}
if get_gem_index("zeus_bolt_gem_2")!= -1{
	atk = weapon_info.atk_impact[get_gem_level("zeus_bolt_gem_2")]
}
if get_gem_index("zeus_bolt_gem_3")!= -1{
	bullet_count = weapon_info.bullet_count[get_gem_level("zeus_bolt_gem_3")]
}
if get_gem_index("zeus_bolt_gem_4")!= -1{
	cycle = weapon_info.cycle_impact[get_gem_level("zeus_bolt_gem_4")]
}

bullet_shape = noone
switch(bullet_style){
	case 0: bullet_shape = spr_zeus_bolt_bullet; break;
	case 1: bullet_shape = spr_zeus_bolt_bullet_1; break;
	case 2: bullet_shape = spr_zeus_bolt_bullet_2; break;
	case 3: bullet_shape = spr_zeus_bolt_bullet_3; break;
	case 4: bullet_shape = spr_zeus_bolt_bullet_4; break;
}