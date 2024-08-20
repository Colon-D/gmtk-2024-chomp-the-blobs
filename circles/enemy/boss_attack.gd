extends Node

@onready var e = $".."

var shot = 0

@export var spike_shot: PackedScene
@export var enemy3_shot: PackedScene

func fire_at_player():
	var players = get_tree().get_nodes_in_group("player")
	if players.size() != 0:
		var shot_type = e.split_into
		if shot % 2 == 0:
			shot_type = enemy3_shot
		for i in range(7):
			var angle = e.position.angle_to_point(players[0].position) +\
				lerp_angle(-0.7, 0.7, i / 6.0)
			var instance = e.split_ratio(
					randf_range(0.004, 0.05),
					angle,
					shot_type
				)
			instance.get_node("movement").speed = 666
			shot += 1
