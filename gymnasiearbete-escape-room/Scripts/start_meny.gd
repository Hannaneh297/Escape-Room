extends Control

func _on_Start_Button_pressed() -> void:
	print("start button pressed")
	get_tree().change_scene_to_file("res://Scenes/Outside.tscn")
