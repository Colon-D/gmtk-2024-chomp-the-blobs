extends HSlider

@onready var master_bus = AudioServer.get_bus_index("Master")

func _value_changed(new_value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus, linear_to_db(new_value))

func _ready() -> void:
	var file = FileAccess.open("user://settings.json", FileAccess.READ)
	if file == null:
		value = db_to_linear(AudioServer.get_bus_volume_db(master_bus))
		return
	var json = JSON.parse_string(file.get_as_text())
	var volume = json["volume"]
	value = volume

func _exit_tree() -> void:
	var json = {
		"volume" : value,
	}
	var file = FileAccess.open("user://settings.json", FileAccess.WRITE)
	file.store_line(JSON.stringify((json)))
