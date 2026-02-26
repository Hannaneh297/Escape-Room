extends Node2D


func _on_inventory_closed() -> void:
	get_tree().paused = false


func _on_inventory_opened() -> void:
	get_tree().paused = true
