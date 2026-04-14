extends Node2D

@onready var Background_music = $Background_music

func play_background_music():
	Background_music.play()

#pauses & unpauses screen when inventory is open no need, dont wanna pause game when invwntory is open


#func _on_inventory_closed() -> void:
#	get_tree().paused = false


#func _on_inventory_opened() -> void:
#	get_tree().paused = true
