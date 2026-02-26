extends Area2D
class_name Key

signal pickup

func _on_body_entered(body: CharacterBody2D) -> void:
	if body is Explorer:
		body.has_key = true
		emit_signal("pickup")
		$AnimationPlayer.play("pickup")



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "pickup":
		queue_free()
