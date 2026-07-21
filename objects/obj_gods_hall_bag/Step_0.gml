if parent_gui.is_wishing {
	if parent_gui.wish_round != my_wish_round {
		my_wish_round = parent_gui.wish_round;
		anim_timer = 0;
	}
	anim_timer++;

	image_index = floor(anim_timer/3)

	if anim_timer == 65 {
		event_user(0);
	}

	if anim_timer >= 149 {
		parent_gui.wish_completed = true;
		anim_timer = 120;
	}
} else if is_hovered {
	anim_timer++;

	image_index = floor(anim_timer/2)

	if anim_timer >= 34 {
		anim_timer = 0;
	}
} else {
	anim_timer = 0
	image_index = 16;
}