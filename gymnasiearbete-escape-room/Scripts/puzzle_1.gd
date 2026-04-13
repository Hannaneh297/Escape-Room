extends Node2D


func play_background_music():
	Background_music.play()


var player_scene = preload("res://Scenes/player.tscn")

@onready var door = $Exit_Door_1
@onready var spawn_point = $PlayerSpawnPoint
@onready var plate = $Pressure_Plate
@onready var Background_music: AudioStreamPlayer2D = $Background_music

func _ready(): 
	plate.activated.connect(_on_plate_activated)            #check if plate is activated, spwans player
	plate.deactivated.connect(_on_plate_deactivated)       
	var player = player_scene.instantiate()
	player.global_position = spawn_point.global_position
	add_child(player)

func _on_plate_activated():        #if activated opens door
	if not door.is_active:
		door.open()

func _on_plate_deactivated():   #if not closes 
	if door.is_active:
		door.close()
