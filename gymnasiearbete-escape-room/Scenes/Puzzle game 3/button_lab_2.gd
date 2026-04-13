extends Node2D


signal activated 

#var pressed_buttons := 0
#var tot_buttons := 3

var is_activated = false
var Explorer_near = false
var player_in_range = false


@onready var sprite : Sprite2D = $Sprite
@onready var Button_lab_label_2 = $Button_lab_label_2
@onready var area_2d: Area2D = $Area2D
@onready var Button_Manager = get_parent().get_parent().get_node("ButtonManager")

"""
func _ready():
	area_2d.body_entered.connect(_on_area_2d_body_entered)
	area_2d.body_exited.connect(_on_area_2d_body_exited)
"""

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("Player"):
		Explorer_near = true
		player_in_range = true
		Button_lab_label_2.visible = true


func _on_area_2d_body_exited(body: CharacterBody2D) -> void:
	if body.is_in_group("Player"):
		Explorer_near = false 
		player_in_range = false
		Button_lab_label_2.visible = false 
		


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("press_button_lab") and Explorer_near and not is_activated:
		activate_button()

func activate_button() -> void:
	is_activated = true
	#sprite.frame = 1  # optional: change sprite to show pressed state
	activated.emit()
	Button_Manager.button_activated()  # notify the manager
	
