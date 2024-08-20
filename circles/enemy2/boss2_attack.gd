extends Node

var angle = 0
var shot = 0

@export var spike_shot: PackedScene

@onready var e = $".."

func fire():
	var spike = (shot % 5 == 4)
	var instance = e.split_ratio(
		randf_range(0.02, 0.1),
		angle,
		spike_shot if spike else e.split_into
	)
	var movement = instance.get_node("movement")
	movement.angle = angle
	if not spike:
		movement.distance = e.radius + instance.radius
		movement.angle_speed = randf_range(0.125, 0.5)
		movement.orbit = e
	movement.speed = randf_range(128, 512)
	angle += randf_range(0.4, 1.2)
	shot += 1

func _physics_process(delta: float) -> void:
	var circles = get_tree().get_nodes_in_group("circle")

	if e.radius < 512:
		for other in circles:
			if other == e or other.is_in_group("player"):
				continue
			var suck_str = (512 - e.radius) / 4
			suck_str *= suck_str * 0.1
			other.position =\
				other.position.move_toward(e.position, delta * suck_str)
