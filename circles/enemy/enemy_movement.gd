extends Node

@onready var e = $".."
var vel = Vector2(0.67, 0.33)

func _physics_process(delta: float) -> void:
	var players = get_tree().get_nodes_in_group("player")
	if players.size() != 0:
		var ratio = players[0].radius / e.radius
		delta *= ratio

	const speed = 256
	e.position += vel * delta * speed

func bounce(normal: Vector2) -> void:
	vel = vel.bounce(normal)
