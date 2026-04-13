extends Control

signal opened
signal closed


var isOpen: bool = false

@onready var grid_container = $NinePatchRect/GridContainer

func _ready():
	#connect funcion to signal to update inventory UI
	Global.inventory_updated.connect(_on_inventory_updated)
	_on_inventory_updated()
	


#Update inventory UI
func _on_inventory_updated():
	#clear existing slots
	clear_grid_container() #refresh and remove ui
	#Add slots for each inventory position 
	for item in Global.inventory:
		var slot = Global.inventory_slot_scene.instantiate()
		grid_container.add_child(slot)
		if item != null: #if there is item
			slot.set_item(item) # show item  data
		else:
			slot.set_empty()

	
func clear_grid_container():
	while grid_container.get_child_count() > 0: 
		var child = grid_container.get_child(0)
		grid_container.remove_child(child)
		child.queue_free() 
		

func open():
	visible = true               
	isOpen = true
	opened.emit()
	
func close():
	visible = false
	isOpen = false
	closed.emit()
	
