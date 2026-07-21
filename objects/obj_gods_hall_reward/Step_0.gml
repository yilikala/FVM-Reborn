if !instance_exists(parent_gui){ 
	instance_destroy();
} else if parent_gui.anim_timer <= 40 {
	instance_destroy();
}

if anim_timer <= 500 {
	anim_timer++;
}


if image_alpha >= 1 {
	image_alpha = 1;
	return;
}

if anim_timer mod 5 == 0 {
	y--;
	image_alpha += 0.1;
}

