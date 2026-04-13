extends CanvasLayer

@onready var inventory = $Inventory

func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		if inventory.isOpen:
			inventory.close()
		else:
			inventory.open()

func _ready():
	inventory.close()
