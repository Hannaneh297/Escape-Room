extends Node2D

var player_scene = preload("res://Scenes/player.tscn")



@onready var spawn_point = $PlayerSpawnPoint
@onready var ButtonManager: Node2D = $ButtonManager
@onready var Background_music: AudioStreamPlayer2D = $Background_music



func play_background_music():
	Background_music.play()



func _ready():
	# Assign the door to the ButtonManager
	var player = player_scene.instantiate()
	player.global_position = spawn_point.global_position
	add_child(player)
	ButtonManager.door = $Exit_Door_2
