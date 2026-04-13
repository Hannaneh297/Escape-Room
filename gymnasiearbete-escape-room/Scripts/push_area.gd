extends Area2D

var current_statue : Pushable_statue = null

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: RigidBody2D) -> void: #the body that goes on top the plate
	if body is Pushable_statue: # the statue is then the body
		current_statue = body

func _on_body_exited(body: Node2D) -> void:
	if body is Pushable_statue:
		current_statue = null

func _physics_process(delta):
	if current_statue:  #interaction of player and statue pushing in direction of plaeyr
		var player = get_tree().get_first_node_in_group("player")
		if player:
			var push_vec = facing_dir_to_vector(player.facing_dir)
			var to_statue = (current_statue.global_position - player.global_position).normalized()

			# Only push if player is moving toward the statue
			if player.velocity.length() > 0 and push_vec.dot(to_statue) > 0.5: 
				current_statue.push_direction = push_vec
			else:
				current_statue.push_direction = Vector2.ZERO

func facing_dir_to_vector(dir: String) -> Vector2:
	match dir:
		"up": return Vector2(0, -1)
		"down": return Vector2(0, 1)
		"left": return Vector2(-1, 0)
		"right": return Vector2(1, 0)
		"up_left": return Vector2(-1, -1).normalized()
		"up_right": return Vector2(1, -1).normalized()
		"down_left": return Vector2(-1, 1).normalized()
		"down_right": return Vector2(1, 1).normalized()
		_: return Vector2.ZERO
