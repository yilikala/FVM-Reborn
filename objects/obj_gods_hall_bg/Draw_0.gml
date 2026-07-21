// 绘制事件
draw_set_alpha(0.5);
// 绘制半透明遮罩
draw_rectangle_color(0, 0, room_width, room_height, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);
draw_self()

// 绘制神谕之石数量
var inv = global.save_data.inventory;
var amt = 0;

for (var i = 0; i < array_length(inv); i++) {
    if (inv[i].id == "oracle_stone") {
        amt = inv[i].amount;
        break;
    }
}

draw_set_font(font_yuan); 
draw_set_color(c_white);
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);
draw_text(1144, 909, string(global.save_data.player.points));
draw_text(1367, 909, string(amt));

// 绘制累计消费
var _spent = global.save_data.player.wish_spent
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
if _spent > 0 && _spent % 200000 == 0 {
	draw_set_color(c_purple);
} else if _spent > 0 && _spent % 50000 == 0 {
	draw_set_color(c_red);
} else {
	draw_set_color(c_yellow);
}
draw_text(639, 285, "当前累计消费为" + string(_spent) + "D")