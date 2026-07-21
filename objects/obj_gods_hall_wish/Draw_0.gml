draw_self()
draw_sprite_ext(spr_gods_hall_wish_count, 0, 981, 770, 1.8, 1.8, 0, c_white, 1)

image_index = 0

if !parent_gui.wish_completed {
	image_index = 2
} else if hovered {
	image_index = 1
    var tooltip_x = x-98;
    var tooltip_y = y+54;
		
	var tooltip_text = "点击消耗10000D\n进行8次赐福"
        
    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_rectangle(tooltip_x - 5, tooltip_y - 5, 
                    tooltip_x + string_width(tooltip_text)+5, tooltip_y + string_height(tooltip_text)+5, false);
        
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_text(tooltip_x, tooltip_y, tooltip_text);
}