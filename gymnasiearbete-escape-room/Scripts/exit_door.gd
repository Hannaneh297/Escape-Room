extends Node2D

signal opened
signal closed

var is_active: bool = false

#@onready var plate: Pressure_plate = $Level_1_puzzle/Node2D/Pressure_Plate
@onready var static_body = $StaticBody2D
@onready var collision = $StaticBody2D/CollisionShape2D
@onready var area = $Area2D
@onready var door = $Sprite2D

func open():
	$Sprite2D.frame = 1
	visible = true               
	is_active = true
	opened.emit()
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
	
func close():
	$Sprite2D.frame = 0
	#visible = false
	is_active = false
	closed.emit()
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
