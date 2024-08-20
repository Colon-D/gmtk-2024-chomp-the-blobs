extends Node

@export_file var gameplay_scene: String
@export_file var gameplay_scene2: String
@export_file var gameplay_scene3: String
@export_file var how_to_play_scene: String
@export_file var credits_scene: String

func on_play_pressed() -> void:
	get_tree().change_scene_to_file(gameplay_scene)

func on_play2_pressed() -> void:
	get_tree().change_scene_to_file(gameplay_scene2)

func on_play3_pressed() -> void:
	get_tree().change_scene_to_file(gameplay_scene3)

func on_toggle_fullscreen_pressed() -> void:
	var mode = DisplayServer.window_get_mode()
	# browser uses fullscreen, not exclusive fullscreen
	if mode == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN or mode == DisplayServer.WINDOW_MODE_FULLSCREEN:
		mode = DisplayServer.WINDOW_MODE_WINDOWED
	else:
		mode = DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
	DisplayServer.window_set_mode(mode)

func on_quit_pressed() -> void:
	get_tree().quit()

func on_how_to_play_pressed() -> void:
	get_tree().change_scene_to_file(how_to_play_scene)

func _input(event: InputEvent) -> void:
	# analog sticks are buggy, sorry :(
	if event.is_action_pressed("ui_up")\
		or event.is_action_pressed("ui_down")\
		or event.is_action_pressed("ui_left")\
		or event.is_action_pressed("ui_right"):
		$drop.play()

func on_credits_pressed() -> void:
	get_tree().change_scene_to_file(credits_scene)
