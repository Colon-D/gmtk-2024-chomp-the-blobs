extends Node

@onready var e = $".."

var shot = 0

@export var spike_shot: PackedScene

func fire_at_player():
	var players = get_tree().get_nodes_in_group("player")
	if players.size() != 0:
		var instance = e.split_ratio(
				0.05,
				e.position.angle_to_point(players[0].position),
				e.split_into if shot % 5 != 0 else spike_shot
			)
		instance.get_node("movement").speed = 1024
		shot += 1
