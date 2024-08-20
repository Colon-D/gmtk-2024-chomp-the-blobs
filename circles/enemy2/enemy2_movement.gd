extends Node

var time_elapsed = 0

@onready var e = $".."

func _physics_process(delta: float) -> void:
	time_elapsed += delta

	e.position = 1024 * Vector2.from_angle(time_elapsed / 2)
