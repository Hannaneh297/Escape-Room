extends Control

var dragging = false
var current_slot = null

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and get_global_rect().has_point(event.position):
			dragging = true
		elif not event.pressed:
			dragging = false
			check_drop()

	elif event is InputEventMouseMotion and dragging:
		global_position = event.position - size / 2
	
	
func check_drop():
	for slot in get_tree().get_nodes_in_group("slots"):
		if slot.get_global_rect().has_point(global_position):
			slot.place_item(self)
			return
	if current_slot:    # If not dropped on slot → snap back
		global_position = current_slot.global_position
	print("Dropped!")
