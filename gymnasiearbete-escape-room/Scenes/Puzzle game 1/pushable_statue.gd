extends RigidBody2D
class_name Pushable_statue

@export var push_speed : float = 40.0 #how fast statue moves

var push_direction : Vector2 = Vector2.ZERO : set = _set_push  #direction for statue, set_push changeds the direction
 
func _physics_process(_delta: float) -> void: #moves the stateu
	linear_velocity = push_direction * push_speed
	pass
	
func _set_push(value: Vector2) -> void:  #set psuh direction
	push_direction = value 
