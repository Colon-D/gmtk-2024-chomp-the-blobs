@tool
extends Node2D

@export var size: Vector2

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		queue_redraw()

func _draw():
	draw_rect(
		Rect2(
			Vector2(-size.x / 2, -size.y / 2),
			Vector2(size.x, size.y)
		),
		Color(0, 0, 0, 0.75)
	)

	draw_dashed_line(
		Vector2(-size.x / 2, -size.y / 2),
		Vector2(size.x / 2, -size.y / 2),
		Color.GRAY, 16, 64
	)
	draw_dashed_line(
		Vector2(size.x / 2, -size.y / 2),
		Vector2(size.x / 2, size.y / 2),
		Color.GRAY, 16, 64
	)
	draw_dashed_line(
		Vector2(size.x / 2, size.y / 2),
		Vector2(-size.x / 2, size.y / 2),
		Color.GRAY, 16, 64
	)
	draw_dashed_line(
		Vector2(-size.x / 2, size.y / 2),
		Vector2(-size.x / 2, -size.y / 2),
		Color.GRAY, 16, 64
	)

	var white = Color.WHITE
	white.a = 0.1
	for y in range(-size.y / 2, size.y / 2, 128):
		draw_line(Vector2(-size.x / 2, y), Vector2(size.x / 2, y), white, 4)
	for x in range(-size.x / 2, size.x / 2, 128):
		draw_line(Vector2(x, -size.y / 2), Vector2(x, size.y / 2), white, 4)
