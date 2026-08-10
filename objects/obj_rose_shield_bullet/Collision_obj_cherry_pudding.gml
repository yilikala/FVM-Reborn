// 反弹：水平/垂直弹需同行，斜向弹不检查
var _is_hv = (direction mod 90 == 0)
var _can_bounce = _is_hv ? (row == other.grid_row) : true
if !bounced && _can_bounce{
	move_speed *= -1
	damage += other.atk
	image_angle += 180
	bounced = true
}
