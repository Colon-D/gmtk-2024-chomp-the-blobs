@tool
extends Node2D

@export var size: Vector2

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		queue_redraw()

func _draw():
	draw_dashed_line(
		Vector2(-size.x / 2, -size.y / 2),
		Vector2(size.x / 2, -size.y / 2),
		Color.WHITE, 16, 16
	)
	draw_dashed_line(
		Vector2(size.x / 2, -size.y / 2),
		Vector2(size.x / 2, size.y / 2),
		Color.WHITE, 16, 16
	)
	draw_dashed_line(
		Vector2(size.x / 2, size.y / 2),
		Vector2(-size.x / 2, size.y / 2),
		Color.WHITE, 16, 16
	)
	draw_dashed_line(
		Vector2(-size.x / 2, size.y / 2),
		Vector2(-size.x / 2, -size.y / 2),
		Color.WHITE, 16, 16
	)
