@tool
extends Node2D

var max_time = 2;
var time_until_fire = max_time;
var ratio = 1
var firing_time = 0
var firing_subtime = 0
var fire_every = 0.05
var shot = 0

@onready var e = $".."
@onready var movement = $"../movement"

@export var spike_shot: PackedScene

func _physics_process(delta: float) -> void:
	delta *= e.dt_mult * 8

	if Engine.is_editor_hint():
		queue_redraw()

	if time_until_fire > 0:
		time_until_fire -= delta
		if time_until_fire <= 0:
			time_until_fire = 0
			firing_time = 0.75
		ratio = time_until_fire / max_time
		queue_redraw()

	rotate(8 * delta * ratio)

	if Engine.is_editor_hint():
		return

	if firing_time > 0:
		firing_time -= delta
		if firing_time <= 0:
			time_until_fire = max_time
			rotation = randf_range(0, 2 * PI)

		firing_subtime -= delta
		while firing_subtime <= 0:
			firing_subtime += fire_every
			fire()

func fire():
	var spike = (shot % 10 == 9)
	var angle = rotation + randf_range(-0.2, 0.2)
	var instance = e.split_ratio(
		randf_range(0.0025, 0.05),
		angle,
		spike_shot if spike else e.split_into
	)
	var instance_movement = instance.get_node("movement")
	instance_movement.speed = randf_range(2048, 4096)
	shot += 1

	movement.vel += 512 * Vector2.from_angle(rotation + PI)

func _draw():
	var color = Color.WHITE
	color.a = 1 - ratio
	var max_radius = 128
	var radius = max_radius * ratio
	draw_rect(Rect2(0, -radius, 4096, radius * 2), color);
	draw_rect(Rect2(0, -max_radius, 4096, max_radius * 2), color, false, 4);
