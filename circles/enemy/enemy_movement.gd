extends Node

@onready var e = $".."
var vel = Vector2(0.67, 0.33)

func _physics_process(delta: float) -> void:
	const speed = 1024
	e.position += vel * delta * e.dt_mult * speed

func bounce(normal: Vector2) -> void:
	vel = vel.bounce(normal)
