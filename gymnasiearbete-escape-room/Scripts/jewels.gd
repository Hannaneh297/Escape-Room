extends Area2D
class_name jewels

signal Pickup


func _on_body_entered(body: CharacterBody2D) -> void:
	if body is Explorer:
		body.has_jewels = true
		emit_signal("Pickup")
		$AnimationPlayer.play("Pickup")
		

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Pickup":
		queue_free()
