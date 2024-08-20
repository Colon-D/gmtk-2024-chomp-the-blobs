extends Node

@onready var e = $".."
@onready var boundary = get_node("/root/gameplay/boundary")
var boss

@export var drain_mult = 1.0

func _ready():
	var bosses = get_tree().get_nodes_in_group("boss")
	if bosses.size() != 0:
		boss = bosses[0]

func _physics_process(delta: float) -> void:
	if boundary == null or boss == null:
		return

	var r = e.radius

	# var x_penetration = max(0, abs(e.position.x) - boundary.size.x / 2 + r)
	# var y_penetration = max(0, abs(e.position.y) - boundary.size.y / 2 + r)

	# var total_penetration = x_penetration + y_penetration

	# var drain_amount = total_penetration * delta * 512
	var drain_amount = drain_mult * e.area / 2 * delta;
	# this won't happen any more? circle now just forces boss to consume small enough circles
	if drain_amount >= e.area:
		# a bit ugly 🤢, the consume function is probably in the wrong script
		boss.get_node("consumer").consume(boss, e)
	else:
		e.area -= drain_amount
		boss.area += drain_amount
