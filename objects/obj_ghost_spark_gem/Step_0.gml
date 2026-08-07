if global.is_paused{
	exit
}
var inst = instance_find(obj_hades_scythe, 0);

if (inst != noone) {
    var cd = inst.cooldown;
	cooldown_timer = cd
}else{cooldown_timer = 0}