extends ScrollContainer

func _physics_process(delta: float) -> void:
	var delta_y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	scroll_vertical += delta_y * 1024 * delta
