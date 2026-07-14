var inst = instance_create_depth(x, y - 60, depth - 1000, obj_flame);
var inst2 = instance_create_depth(x, y - 60, depth - 1000, obj_flame);
var inst3 = instance_create_depth(x, y - 60, depth - 1000, obj_flame);
var inst4 = instance_create_depth(x, y - 60, depth - 1000, obj_flame);
var inst5 = instance_create_depth(x, y - 60, depth - 1000, obj_flame);
var inst6 = instance_create_depth(x, y - 60, depth - 1000, obj_flame);
if shape >= 1{
	var inst7 = instance_create_depth(x, y - 60, depth - 1000, obj_flame);
	inst7.value = flame_produce
}
if shape >= 2{
	var inst8 = instance_create_depth(x, y - 60, depth - 1000, obj_flame);
	inst8.value = flame_produce
}
if shape == 3{
	var inst9 = instance_create_depth(x, y - 60, depth - 1000, obj_flame);
	var inst10 = instance_create_depth(x, y - 60, depth - 1000, obj_flame);
	var inst11 = instance_create_depth(x, y - 60, depth - 1000, obj_flame);
	var inst12 = instance_create_depth(x, y - 60, depth - 1000, obj_flame);
	inst9.value = flame_produce
	inst10.value = flame_produce
	inst11.value = flame_produce
	inst12.value = flame_produce
}
inst.value = flame_produce
inst2.value = flame_produce
inst3.value = flame_produce
inst4.value = flame_produce
inst5.value = flame_produce
inst6.value = flame_produce