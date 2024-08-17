@tool
extends Node2D

signal radius_changed(value: float)

@export var radius: float:
	set(value):
		radius = value
		radius_changed.emit(radius)
		queue_redraw()
@export var color: Color

func _physics_process(_delta: float) -> void:
	if Engine.is_editor_hint():
		queue_redraw()

func _draw():
	draw_circle(Vector2.ZERO, radius, color, true);
	draw_circle(Vector2.ZERO, radius, Color.WHITE, false, 16);
