extends Node2D
class_name Pressure_plate

signal activated
signal deactivated

var bodies : int = 0 #amount of collision body on top
var is_active : bool = false
var off_rect : Rect2

@onready var area_2d : Area2D = $Area2D
@onready var sprite : Sprite2D = $Sprite2D
#@onready var audio_activated : AudioStream = preload("")
#@onready var audio_activated : AudioStream = preload("")
	
	
func _ready() -> void:                          
	area_2d.body_entered.connect(_on_body_entered)
	area_2d.body_exited.connect(_on_body_exited)
	off_rect = sprite.region_rect  #change of frames

	
func _on_body_entered (_body : Node2D) -> void: #if it detects a body it goes to func check 
	bodies += 1                                 # if body is there turns true door opens
	check_is_activated()
	pass
	

func _on_body_exited(_body: Node2D) -> void:    
	bodies -= 1
	check_is_activated()
	pass # Replace with function body.

	

func check_is_activated() -> void: #ddetermine the amount of bodies and if it is pressed
	if bodies > 0 and is_active == false: 
		is_active = true
		sprite.region_rect.position.x = off_rect.position.x - 32
		activated.emit()
	elif bodies <= 0 and is_active == true: 
		is_active = false
		sprite.region_rect.position.x = off_rect.position.x
		deactivated.emit()
