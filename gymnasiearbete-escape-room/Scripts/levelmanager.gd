extends Node2D


@onready var anim: AnimationPlayer = $AnimationPlayer

var next_spawn : String

func change_scene_to(path: String, spawn_name: String) -> void:
	next_spawn = spawn_name
	anim.play("fade_in")
	await anim.animation_finished
	
	anim.play("fade_out")
	
	get_tree().change_scene_to_file(path)
	await get_tree().create_timer(1).timeout
	
	move_player_to_spawn()
	
func move_player_to_spawn():
	var player = get_tree().get_first_node_in_group("player")
	var spawn = get_tree().current_scene.get_node_or_null(next_spawn)
	
	if player and spawn:
		player.global_position = spawn.global_position
			
			

	anim.play("fade_out")
	
