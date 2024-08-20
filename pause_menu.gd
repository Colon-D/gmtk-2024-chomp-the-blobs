extends CanvasItem

@export_file var menu_scene: String

signal on_pause()
signal on_unpause()

func on_win():
	get_tree().paused = true
	visible = true
	on_pause.emit()
	$label.text = "You win! 😀"
	$return.queue_free()
	$menu.grab_focus()

func on_lose():
	get_tree().paused = true
	visible = true
	on_pause.emit()
	$label.text = "You lose... 🙁"
	$return.queue_free()
	$menu.grab_focus()

func _input(event):
	if event.is_action_released("pause"):
		get_tree().paused = not get_tree().paused
		visible = get_tree().paused
		if get_tree().paused:
			on_pause.emit()
		else:
			on_unpause.emit()
		$return.grab_focus()

	if get_tree().paused and (\
		# analog sticks are buggy, sorry :(
		event.is_action_pressed("ui_up")\
		or event.is_action_pressed("ui_down")\
		or event.is_action_pressed("ui_left")\
		or event.is_action_pressed("ui_right")):
		$drop.play()

func on_return_pressed() -> void:
	get_tree().paused = false
	visible = get_tree().paused
	on_unpause.emit()

func on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(menu_scene)

func on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
