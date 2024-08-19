extends AudioStreamPlayer2D

func on_consume(_consumer, other):
	pitch_scale = other.dt_mult * 8 # dt_mult is being used as a ratio here
	play()

func edge(_normal):
	pitch_scale = $"..".dt_mult * 8
	play()

func on_split(instance):
	pitch_scale = instance.dt_mult * 8
	play()
