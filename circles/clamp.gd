extends Node

@onready var e = $".."
@onready var boundary = get_node("/root/gameplay/boundary")

signal edge(normal: Vector2)

func _physics_process(_delta: float) -> void:
	if boundary == null:
		return

	var r = e.radius

	if e.position.x < -boundary.size.x / 2 + r:
		e.position.x = -boundary.size.x / 2 + r
		edge.emit(Vector2(1, 0))
	elif e.position.x > boundary.size.x / 2 - r:
		e.position.x = boundary.size.x / 2 - r
		edge.emit(Vector2(-1, 0))
	if e.position.y < -boundary.size.y / 2 + r:
		e.position.y = -boundary.size.y / 2 + r
		edge.emit(Vector2(0, 1))
	elif e.position.y > boundary.size.y / 2 - r:
		e.position.y = boundary.size.y / 2 - r
		edge.emit(Vector2(0, -1))
