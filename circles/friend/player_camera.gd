extends Camera2D

@export var follow: NodePath

func _physics_process(_delta: float) -> void:
	var follow_node = get_node_or_null(follow)
	if follow_node == null:
		return
	position = follow_node.position
	zoom = 48 * Vector2.ONE / follow_node.radius
