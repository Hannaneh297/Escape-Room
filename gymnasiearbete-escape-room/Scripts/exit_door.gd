extends Node2D

signal opened
signal closed

var is_active: bool = false

var isopen: bool = false
var Explorer_near: bool = false 
var transitioning = false

#@onready var plate: Pressure_plate = $Level_1_puzzle/Node2D/Pressure_Plate
@onready var static_body = $StaticBody2D
@onready var collision = $StaticBody2D/CollisionShape2D
@onready var area = $Area2D
@onready var door = $Sprite2D
@export var target_scene : String
@export var target_spawn : String

func open():
	$Sprite2D.frame = 1
	visible = true               
	is_active = true
	isopen = true
	opened.emit()
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
	
func close():
	$Sprite2D.frame = 0
	#visible = false
	is_active = false
	isopen = false 
	closed.emit()
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)  #gets removed to walk through
	


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body is Explorer:
		print(body)
		Explorer_near = true


func _on_area_2d_body_exited(body: CharacterBody2D) -> void:
	if body is Explorer:
		Explorer_near = false
		
func _on_exit_trigger_body_entered(body: Node2D) -> void:
	if body is Explorer and isopen and not transitioning:
		transitioning = true
		await get_tree().create_timer(1).timeout
		Levelmanager.change_scene_to(target_scene, target_spawn)

		
#func _ready():
#	exit_trigger.body_entered.connect(_on_exit_trigger_body_entered) #not needed triggered the game 
	
	
	
