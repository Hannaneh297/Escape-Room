extends Control

func _on_restart_button_pressed() -> void:
	print("restart button pressed")
	get_tree().change_scene_to_file("res://Scenes/Outside.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
