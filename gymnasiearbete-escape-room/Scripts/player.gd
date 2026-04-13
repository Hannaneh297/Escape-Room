extends CharacterBody2D
class_name Explorer



const JUMP_VELOCITY = 300

enum { IDLE, WALK , JUMP}



var SPEED = 100
var state = IDLE
var has_key: bool = false
var has_jewels: bool = false
var jump: bool = false
var jump_time: float = 0.0 
var jump_duration: float = 0.3
var jump_height: float = 0.0


@onready var left_ray: RayCast2D = $LeftRay
@onready var right_ray: RayCast2D = $RightRay
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var footstep: AudioStreamPlayer2D = $Footstep



var facing_dir = "down"
var last_facing_dir = "down"



func _ready():
	add_to_group("player")
	Global.set_player_reference(self)
	anim.frame_changed.connect(_on_frame_changed) 


func _physics_process(delta: float) -> void:
	var x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	var input_vector = Vector2(x, y).normalized()
	facing_dir = _get_direction_name(input_vector)
	if facing_dir != "":
		last_facing_dir = facing_dir
	if not jump:
		_play_anim(input_vector)
	
	
	if Input.is_action_just_pressed("jump") and not jump:
		state = JUMP
		jump = true
		jump_time = jump_duration
	
	if jump: 
		state = JUMP
	elif input_vector.length() == 0:
		state = IDLE
	else:
		state = WALK
		
	match state:
		IDLE:
			_idle_state(delta)
		WALK:
			_walk_state(delta, input_vector)
		JUMP:
			_jump_state(delta, input_vector)




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

func _jump_state(delta, input_vector):
	jump_time -= delta 
	velocity = input_vector * SPEED * 1.5
	move_and_slide()

	var progress = 1.0 - (jump_time / jump_duration)
	jump_height = sin(progress * PI) * 20
	
	if jump_time <= 0:
		jump = false
	
	$AnimatedSprite2D.offset.y = -jump_height #fakes height to make jumping more realistic

	
	



func _on_frame_changed():
	if state != WALK:
		return
	




func _play_anim(input_vector: Vector2) -> void:  #plays animation idle or walk based and movement and placement
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


																											  

func apply_item_effect(item):   #applies th effects an item have
	match item["effect"]: 
		"stamina":
			SPEED += 20
			print("Speed increased to", SPEED)
		_:
			print("This item has no effect ")
			
		
#make the camera be zoomed out at the beginning and the it zooms in to the zoom of choice after a while. 
#so you can see the whole map at the beginning
