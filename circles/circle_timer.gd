extends Node

@export var wait_time: float
@export var one_shot: bool
@export var autostart: bool

@onready var circle = $"../.."

var time_left = INF

signal timeout()

func start() -> void:
	time_left = wait_time

func _ready() -> void:
	if autostart:
		start()

func _physics_process(delta: float) -> void:
	time_left -= delta * circle.dt_mult
	if time_left <= 0:
		timeout.emit()
		if one_shot:
			time_left = INF
		else:
			start()
	pass
