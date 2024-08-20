extends Label

var time_elapsed = 0
var best_time = INF

@export var boss_name: String

func _physics_process(delta: float) -> void:
	time_elapsed += delta
	text = str(floor(time_elapsed * 100) / 100)

func _ready() -> void:
	load_from_file()

func load_from_file() -> void:
	var file = FileAccess.open("user://" + boss_name + ".save", FileAccess.READ)
	if file == null:
		return

	var json = JSON.parse_string(file.get_as_text())
	best_time = json["best_time"]

func save_to_file() -> void:
	if time_elapsed < best_time:
		best_time = time_elapsed

	var json = {
		"best_time" : best_time,
	}

	var file = FileAccess.open("user://" + boss_name + ".save", FileAccess.WRITE)
	file.store_line(JSON.stringify((json)))