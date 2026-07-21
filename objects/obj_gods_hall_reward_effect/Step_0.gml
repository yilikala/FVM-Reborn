if !instance_exists(parent_gui) {
	instance_destroy()
}

if image_alpha >= 1 {
	anim_timer = 0
	image_alpha = 1;
	return;
}

anim_timer++;

if anim_timer mod 5 == 0 {
	y--;
	image_alpha += 0.1;
}

if anim_timer >= 45 {
	anim_timer = 0;
}