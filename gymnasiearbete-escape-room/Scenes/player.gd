extends CharacterBody2D
class_name Explorer

const SPEED = 100
enum { IDLE, WALK }
var state = IDLE
var dir: int = 1

@onready var left_ray: RayCast2D = $LeftRay
@onready var right_ray: RayCast2D = $RightRay
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D


# possible values:
# "up", "down", "left", "right", 
# "up_left", "up_right", "down_left", "down_right"
var facing_dir = "down"


func _physics_process(delta: float) -> void:
	var x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	var input_vector = Vector2(x, y)
	_play_anim(input_vector)
	
	match state:
		IDLE:
			_idle_state(delta)
		WALK:
			_walk_state(delta)
		
			

	# No movement → idle
	#if input_vector == Vector2.ZERO:
	#	state = IDLE
	#		return

	# Movement → walking
	state = WALK
	velocity = input_vector.normalized() * SPEED

	# --- UPDATE FACING DIRECTION FOR 8 DIRECTIONS ---
	facing_dir = _get_direction_name(input_vector)


func _get_direction_name(v: Vector2) -> String:
	var dir = ""

	# Vertical
	if v.y < 0:
		dir += "up"
	elif v.y > 0:
		dir += "down"

	# Horizontal
	if v.x < 0:
		dir += ("_left" if dir != "" else "left")
	elif v.x > 0:
		dir += ("_right" if dir != "" else "right")

	return dir


func _idle_state(delta):

	velocity = velocity.move_toward(Vector2.ZERO, 20)
	move_and_slide()


func _walk_state(delta):
	move_and_slide()

"""
func _format_dir(d: String) -> String:
	# Convert "down_left" → "Down_Left"
	var parts = d.split("_")
	for i in range(parts.size()):
		parts[i] = parts[i].capitalize()
	return "_".join(parts)
"""

func _play_anim(input_vector: Vector2) -> void:
	if input_vector.x == 0 and input_vector.y == 1:
		anim.play("Walk_Down")
	elif input_vector.x == 0 and input_vector.y == -1:
		anim.play("Walk_Up")
	elif input_vector.x == 1 and input_vector.y == 1:
		anim.play("Walk_Right_Down")
	elif input_vector.x == 1 and input_vector.y == -1:
		anim.play("Walk_Right_Up")
	elif input_vector.x == -1 and input_vector.y == 1:
		anim.play("Walk_Left_Down")
	elif input_vector.x == -1 and input_vector.y == -1:
		anim.play("Walk_Left_Up")


#make the camera be zoomed out at the beginning and the it zooms in to the zoom of choice after a while. 
#so you can see the whole map at the beginning
