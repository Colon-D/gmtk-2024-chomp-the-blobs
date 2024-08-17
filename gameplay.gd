extends Node

@export var enemy: PackedScene

func _ready() -> void:
	for a in range(0, 360, 1):
		var instance = enemy.instantiate()
		var mov = instance.get_node("movement")
		mov.vel = Vector2.from_angle(deg_to_rad(a + randf_range(-2, 2)))
		instance.radius = randf_range(16, 64)
		instance.position = mov.vel * 4096
		add_child(instance)
