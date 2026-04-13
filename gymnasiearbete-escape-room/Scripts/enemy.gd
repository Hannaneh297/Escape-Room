extends CharacterBody2D

const SPEED = 70


var chase_player = false
var player = null




func _physics_process(delta):
	if chase_player and player != null:
		var direction = player.global_position - global_position
		if direction.length() > 20:
			velocity = direction.normalized() * SPEED
		else:
			velocity = Vector2.ZERO
	else:
		velocity = Vector2.ZERO

	move_and_slide()


func _on_detection_area_body_entered(body): # detects player , if player in area it follows it
	if body is Explorer:
		player = body
		chase_player = true


func _on_detection_area_body_exited(body):
	if body is Explorer:
		player = null
		chase_player = false
		velocity = Vector2.ZERO
