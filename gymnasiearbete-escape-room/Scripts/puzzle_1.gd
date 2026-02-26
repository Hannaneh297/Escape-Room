extends Node2D

var player_scene = preload("res://Scenes/player.tscn")


@onready var plate = $Pressure_Plate
@onready var door = $Exit_Door_1
@onready var spawn_point = $PlayerSpawnPoint

func _ready():
	plate.activated.connect(_on_plate_activated)
	plate.deactivated.connect(_on_plate_deactivated)
	var player = player_scene.instantiate()
	player.global_position = spawn_point.global_position
	add_child(player)

func _on_plate_activated():
	if not door.is_active:
		door.open()

func _on_plate_deactivated():
	if door.is_active:
		door.close()
		
		
