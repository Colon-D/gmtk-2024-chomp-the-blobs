extends Node

@export var projectile: PackedScene

@onready var e = $".."

signal on_fire(instance: Node)

func fire(ratio: float, angle: float):
	var instance = projectile.instantiate()
	instance.position = e.position
	var dir = Vector2.from_angle(angle + randf_range(-0.1, 0.1))
	instance.get_node("movement").vel = dir
	# don't spawn inside of this!
	instance.position += dir * e.radius * 1.01

	var e_area = e.radius * e.radius * PI
	var new_area = e_area * (1 - ratio)
	e.radius = sqrt(new_area / PI)

	var instance_area = e_area * ratio
	instance.radius = sqrt(instance_area / PI)

	e.get_parent().add_child(instance)

	on_fire.emit(instance)

func fire_at_player():
	var players = get_tree().get_nodes_in_group("player")
	if players.size() != 0:
		fire(0.05, e.position.angle_to_point(players[0].position))
