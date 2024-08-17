extends AudioStreamPlayer2D

@onready var last_pos = global_position

func _physics_process(delta: float) -> void:
	var velocity = 32 * ((global_position - last_pos) / delta) / $"..".radius

	volume_db = lerp(-16, 0, min(velocity.length() / 512, 1))

	last_pos = global_position
