extends StaticBody2D

signal closed_chest 
signal opened_chest
var opened: bool = false


func open_chest():
	visible = true
	opened = true
	opened_chest.emit()

	
	
func close_chest():
	visible = false
	opened = false
	closed_chest.emit()
