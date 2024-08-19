@tool
extends Node2D

signal radius_changed(value: float)
signal on_consumed()

@export var radius: float:
	set(value):
		radius = value
		radius_changed.emit(radius)
		queue_redraw()

var area: float:
	get:
		return radius * radius * PI
	set(value):
		radius = sqrt(value / PI)
@export var color: Color
var dt_mult = 1

@export var big_color = Color.RED.lightened(0.5)
@export var same_color = Color.ORANGE_RED.lightened(0.5)
@export var small_color = Color.ORANGE.lightened(0.5)

# if null, duplicates self
@export var split_into: PackedScene

func _enter_tree():
	update_dt_mult()

func update_dt_mult():
	var players = get_tree().get_nodes_in_group("player")
	if players.size() != 0:
		var player = players[0]

		var ratio = player.area / area

		dt_mult = clamp(ratio, 0.1, 1.0) # todo: remove? just unfun? fix audio then
		# or just make tiny spikes not matter

		if is_in_group("boss") or is_in_group("player"):
			return

		var rel_size = get_relative_size(player)
		if rel_size == relative_size.SMALL:
			color = big_color
		elif rel_size == relative_size.BIG:
			color = small_color
		else:
			color = same_color
		queue_redraw()

signal on_split(instance: Node)

func explode(lose_ratio = 0.75, split_into_amount = 6):
	var lose_area = lose_ratio * area
	var instance_area = lose_area / split_into_amount
	for i in range(split_into_amount):
		var angle = 2 * i * PI / split_into_amount
		var instance = split_area(instance_area, angle, split_into)
		instance.get_node("movement").speed = 256

func split_area(instance_area: float, angle: float, into: PackedScene):
	var instance_radius = sqrt(instance_area / PI)
	return split_radius(instance_radius, angle, into)

func split_ratio(ratio: float, angle: float, into: PackedScene):
	var instance_area = area * ratio
	var instance_radius = sqrt(instance_area / PI)
	return split_radius(instance_radius, angle, into)

func split_radius(instance_radius: float, angle: float, into: PackedScene):
	var instance
	if (into == null):
		instance = duplicate()
	else:
		instance = into.instantiate()

	var movement = instance.get_node("movement")
	movement.angle = angle
	# don't spawn inside of this!
	instance.radius = instance_radius
	area -= instance.area
	instance.position = position
	instance.position += Vector2.from_angle(angle) * radius * 1.01

	get_parent().add_child(instance)
	on_split.emit(instance)
	return instance

var debug_split_last_frame = true
func _physics_process(_delta: float) -> void:
	if Engine.is_editor_hint():
		queue_redraw()
		return

	update_dt_mult();

	if is_in_group("spike") and radius > 128:
		#var instance = split_into.instantiate();
		explode()
		#instance.consume(instance, self)

	if debug_split_last_frame:
		if not Input.is_key_pressed(KEY_3):
			debug_split_last_frame = false
	else:
		if Input.is_key_pressed(KEY_3):
			debug_split_last_frame = true
			explode()
			#split_area(area / 2, 0, split_into)

func _draw():
	draw_circle(Vector2.ZERO, radius + 8, Color.WHITE, true);
	draw_circle(Vector2.ZERO, radius - 8, color, true);

enum relative_size { SMALL, SAME, BIG }
func get_relative_size(other):
	var ratio_needed = 1.0 if is_in_group("spike") or other.is_in_group("spike") else 1.25
	var ratio = radius / other.radius
	if ratio >= ratio_needed:
		return relative_size.SMALL
	elif 1 / ratio >= ratio_needed:
		return relative_size.BIG
	else:
		return relative_size.SAME
