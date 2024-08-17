extends Node

@onready var e = $".."

func _physics_process(delta: float) -> void:
	delta *= e.radius / 32

	var x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	const speed = 256
	e.position += Vector2(x, y) * delta * speed
