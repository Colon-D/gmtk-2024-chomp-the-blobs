extends Label

func _process(delta: float) -> void:
	text = "FPS: " + str(round(1 / delta))
