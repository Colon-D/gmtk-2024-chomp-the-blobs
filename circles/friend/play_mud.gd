extends AudioStreamPlayer2D

func on_consume(consumer, other):
	pitch_scale = other.dt_mult * 8 # dt_mult is being used as a ratio here
	play()

func edge(_normal):
	pitch_scale = $"..".dt_mult * 8
	play()

func on_fire(instance):
	pitch_scale = instance.dt_mult * 8
	play()
