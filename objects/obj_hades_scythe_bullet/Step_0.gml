if global.is_paused {
    image_speed = 0
	speed = 0
    exit
}

image_speed = 2
speed = 4.8

// 推进参数（关键：来回用同一个 t）
t += speed * dir;

// 到达右端 → 开始回程
if (t >= 950) {
    t = 950;
    dir = -1;
}

// 回到起点 → 销毁
if (t <= 0 && dir == -1) {
    disabled = true
	instance_destroy();
    exit;
}

// ===== 透明度控制 =====
if (t <= 40) {
    image_alpha = 0;
} else {
    image_alpha = 1;
}

// 计算轨迹
var px = t;
var py = -14 * sqrt(px) * sin(2 * pi / 950 * px);

// 回程取反（关键）
if (dir == -1) {
    py = -py;
}

// 应用位置
x = start_x + px;
y = start_y + py;