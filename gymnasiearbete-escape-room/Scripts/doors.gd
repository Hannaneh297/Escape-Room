extends Node2D

signal opened
signal closed

var isopen: bool = false
var Explorer_near: bool = false 
var transitioning = false

@export var target_scene : String
@export var target_spawn : String

@onready var static_body = $StaticBody2D
@onready var collision = $StaticBody2D/CollisionShape2D
@onready var area = $Area2D
@onready var door = $Sprite2D
@onready var exit_trigger = $ExitTrigger




func open():
	$Sprite2D.frame = 1
	visible = true               
	isopen = true
	opened.emit()
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)

	
	
func close():
	$Sprite2D.frame = 0
	#visible = false
	isopen = false
	closed.emit()
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)


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
	
	
	
func _input(event):   #om E är tryckt om dörren är öppen ska dörren stängas annars ska den öppnas.
	if event.is_action_pressed("door_open") and Explorer_near:
		if isopen:
			close()
		else:
			open()
		
