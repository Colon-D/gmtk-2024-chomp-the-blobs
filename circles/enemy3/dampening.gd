extends Node

@onready var m = $".."

func _physics_process(delta: float) -> void:
	m.speed -= delta * m.speed / 2
