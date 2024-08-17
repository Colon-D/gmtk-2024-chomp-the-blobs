extends Node

@onready var e = $".."

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("debug_shrink"):
		e.radius *= 1 - 1 * delta
	if Input.is_action_pressed("debug_grow"):
		e.radius *= 1 + 1 * delta
