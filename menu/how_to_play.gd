extends Node2D

@export_file var menu_scene: String

func on_back_pressed() -> void:
    get_tree().change_scene_to_file(menu_scene)
