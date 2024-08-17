extends Node

@onready var e = $".."
@onready var r = $"../radius"

func _draw()
	draw_circle(e.position, r.radius, Color(1, 1, 1, 0.5))
