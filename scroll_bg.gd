extends Sprite2D

@export var vel: Vector2

func _physics_process(delta: float) -> void:
	region_rect.position += delta * vel
