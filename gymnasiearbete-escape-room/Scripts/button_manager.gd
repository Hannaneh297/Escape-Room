extends Node2D

var activated_buttons := 0
var tot_buttons := 3
var door: Node = null  # assign door from labyrinth scene


func button_activated():
	activated_buttons += 1
	print("Button pressed! Total:", activated_buttons)
	if activated_buttons >= tot_buttons and door:
		open_door()

func open_door():
	if door.has_method("open"):
		door.open()
	else:
		door.visible = false  # simple example if no method
	print("All buttons pressed! Door is now open.")
