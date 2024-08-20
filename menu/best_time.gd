extends Label

@export var boss_name: String

func _ready() -> void:
	load_from_file()

func load_from_file() -> void:
	var file = FileAccess.open("user://" + boss_name + ".save", FileAccess.READ)
	if file == null:
		return

	var json = JSON.parse_string(file.get_as_text())
	var best_time = json["best_time"]
	text = "Best: " + str(floor(best_time * 100) / 100)
