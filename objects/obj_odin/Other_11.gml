var inst = instance_create_depth(x+40,y-75,depth-500,obj_odin_bullet)
inst.damage = atk
inst.move_speed = 8
inst.row = grid_row
inst.shape = shape

if shape == 0 { inst.sprite_index = spr_odin_bullet }
else if shape == 1 { inst.sprite_index = spr_odin_bullet_1 }
else if shape == 2 { inst.sprite_index = spr_odin_bullet_2 }
else { inst.sprite_index = spr_odin_bullet_3 }

audio_play_sound(snd_shot, 0, 0)
