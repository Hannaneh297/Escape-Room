extends CharacterBody2D
class_name Explorer

const SPEED = 100
enum { IDLE, WALK }
var state = IDLE
var has_key: bool = false
var has_jewels: bool = false


@onready var left_ray: RayCast2D = $LeftRay
@onready var right_ray: RayCast2D = $RightRay
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var footstep: AudioStreamPlayer2D = $Footstep



var facing_dir = "down"
var last_facing_dir = "down"

func _ready():
	add_to_group("player")
	add_to_group("player")
	anim.frame_changed.connect(_on_frame_changed)


func _physics_process(delta: float) -> void:
	var x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	var input_vector = Vector2(x, y).normalized()
	facing_dir = _get_direction_name(input_vector)
	if facing_dir != "":
		last_facing_dir = facing_dir
	_play_anim(input_vector)
	
	if input_vector.length() == 0:
		state = IDLE
	else:
		state = WALK
		
	match state:
		IDLE:
			_idle_state(delta)
		WALK:
			_walk_state(delta, input_vector)




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
	
func _idle_state(_delta):

	velocity = velocity.move_toward(Vector2.ZERO, 20)
	move_and_slide()


func _walk_state(_delta, input_vector):
	velocity = velocity.move_toward(input_vector*SPEED, 20)
	move_and_slide()
	

func play_footstep():
	if state == WALK:
		footstep.play()


func _on_frame_changed():
	if state != WALK:
		return
	
	if anim.frame == 0 or anim.frame == 7:
		footstep.stop()
		footstep.play()


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
	elif input_vector.x == 1:
		anim.play("Walk_Right_Down") #right
	elif input_vector.x == -1:
		anim.play("Walk_Left_Down")	

	elif last_facing_dir == "up":
		anim.play("Idle_Up")
	elif last_facing_dir == "right_up":
		anim.play("Idle_Right_Up")
	elif last_facing_dir == "right":
		anim.play("Idle_Right")
	elif last_facing_dir == "right_down":
		anim.play("Idle_Right_Down")
	elif last_facing_dir == "left_up":
		anim.play("Idle_Left_Up")
	elif last_facing_dir == "left_down":
		anim.play("Idle_Left_Down")
	elif last_facing_dir == "left":
		anim.play("Idle_Left")
	elif last_facing_dir == "down":
		anim.play("Idle_Down")                                                                                                                             
	
		
		


#make the camera be zoomed out at the beginning and the it zooms in to the zoom of choice after a while. 
#so you can see the whole map at the beginning
