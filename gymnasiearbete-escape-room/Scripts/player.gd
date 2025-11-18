extends CharacterBody2D
class_name Player

const MAX_SPEED = 400
const ACC = 2500
const GRAVITY = 1250
const KNOCKBACK_SPEED = 700

enum{IDLE, WALK} 

var state = IDLE

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var left_ray: RayCast2D = $LeftRay
@onready var right_ray: RayCast2D = $RightRay

############### GAME LOOP ##############################
func _physics_process(delta: float) -> void:
	match state:
		IDLE:
			_idle_state(delta)
		WALK:
			_walk_state(delta)

############### GENERAL HELP FUNCTIONS ########################
func _movement(delta: float, input_x: float) -> void:
	if up_direction.is_equal_approx(Vector2.UP) or up_direction.is_equal_approx(Vector2.DOWN):
		if input_x != 0:
			velocity.x =  move_toward(velocity.x, input_x*MAX_SPEED*(-sin(up_direction.angle())), ACC*delta)
		else:
			velocity.x = move_toward(velocity.x, 0, ACC*delta)
			
		velocity.y += -up_direction.y * GRAVITY * delta
		apply_floor_snap()
		move_and_slide()
	else:
		if input_x != 0:
			velocity.y =  move_toward(velocity.y, input_x*MAX_SPEED*(cos(up_direction.angle())), ACC*delta)
		else:
			velocity.y = move_toward(velocity.y, 0, ACC*delta)
		velocity.x += -up_direction.x * GRAVITY * delta
		apply_floor_snap()
		move_and_slide()

func _update_direction(input_x: float) -> void:
	if input_x > 0:
		sprite.flip_h = false
	elif input_x < 0:
		sprite.flip_h = true

"""
UPPGFT: skapa en funktion _on_edge() som kontrollerar om spelaren är på en kant
eller inte. Funktionen ska returnera "left", "right" eller "" beroende på. 
Detta med hjälp av Raycasts (LeftRay och RightRay)
"""
func _on_edge() -> String:
	if left_ray.is_colliding() and not right_ray.is_colliding():
		return "right"
	elif not left_ray.is_colliding() and right_ray.is_colliding():
		return "left"
	else:
		return ""


############### STATE FUNCTIONS ########################
func _idle_state(delta: float) -> void:
	#1
	var input_x = Input.get_axis("move left", "move right")
	_update_direction(input_x)
	#2
	_movement(delta, input_x)
	#3
func _walk_state(delta: float) -> void:
	#1
	var input_x = Input.get_axis("move left", "move right")
	_update_direction(input_x)
	#2
	_movement(delta, input_x)
	#3


############### ENTER STATE FUNCTION #######################
func _enter_idle_state():
	$AnimatedSprite2D.play("idle")

func _enter_walk_state():
	$AnimatedSprite2D.play("walk")







################ PUBLIC FUNCTIONS ################################

	$CollisionShape2D.set_deferred("disabled", true)
	$RemoteTransform2D.remote_path = ""
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rotation", rotation + PI, 0.5)
		
		


################## SIGNALS #############################



	#print("DÖÖÖÖD")
