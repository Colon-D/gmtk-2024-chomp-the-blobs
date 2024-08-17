@tool
extends Node2D

signal radius_changed(value: float)

@export var radius: float:
	set(value):
		radius = value
		radius_changed.emit(radius)
		queue_redraw()
@export var color: Color
var dt_mult = 1

func _enter_tree():
	update_dt_mult()

func update_dt_mult():
	var players = get_tree().get_nodes_in_group("player")
	if players.size() != 0:
		var player = players[0]

		var ratio = player.radius / radius
		dt_mult = ratio

		if is_in_group("boss") or is_in_group("player"):
			return

		if ratio >= 1.25:
			color = Color.ORANGE.lightened(0.5)
		elif 1 / ratio >= 1.25:
			color = Color.RED.lightened(0.5)
		else:
			color = Color.ORANGE_RED.lightened(0.5)
		queue_redraw()

func _physics_process(_delta: float) -> void:
	if Engine.is_editor_hint():
		queue_redraw()
		return

	update_dt_mult();

func _draw():
	draw_circle(Vector2.ZERO, radius, color, true);
	draw_circle(Vector2.ZERO, radius, Color.WHITE, false, 16);
