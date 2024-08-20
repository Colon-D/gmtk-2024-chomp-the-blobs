extends Node

@export var orbit: Node2D
@export var speed = 512
@export var angle_speed = 1
@export var angle = 0
@export var distance = 512
var elapsed_time = 0

@onready var e = $".."

func _physics_process(delta: float) -> void:
	delta *= e.dt_mult
	elapsed_time += delta
	if orbit == null:
		return
	e.position = orbit.position + Vector2.from_angle(angle) * distance
	angle += delta * angle_speed
	distance += delta * speed * cos(min(elapsed_time, PI))
