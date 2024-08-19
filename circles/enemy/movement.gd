extends Node

@onready var e = $".."

var vel: Vector2:
	set(value):
		speed = value.length()
		angle = value.angle()
	get:
		return Vector2.from_angle(angle) * speed
@export var speed: float
@export var angle: float

func _physics_process(delta: float) -> void:
	e.position += vel * delta * e.dt_mult

func bounce(normal: Vector2) -> void:
	vel = vel.bounce(normal)
