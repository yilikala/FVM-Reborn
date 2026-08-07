// 纯动画外壳：暂停时动画冻结，播放完成后销毁
if global.is_paused{
	image_speed = 0
	exit
}
image_speed = 3

timer++
if timer >= explode_timer{
	instance_destroy()
}
