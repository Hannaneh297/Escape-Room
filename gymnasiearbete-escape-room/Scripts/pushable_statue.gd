extends RigidBody2D
class_name Pushable_Statue

@export var push_speed : float = 30.0

var push_direction : Vector2 = Vector2.ZERO : set = _set_push
 
func _physics_process(_delta: float) -> void:
	linear_velocity = push_direction * push_speed
	pass
	
func _set_push(value: Vector2) -> void: 
	push_direction = value 
