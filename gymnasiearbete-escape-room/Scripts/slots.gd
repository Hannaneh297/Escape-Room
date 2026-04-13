extends Panel


#Scene-Tree Node refrence 

@onready var icon = $Item_icon
@onready var quantity_label = $Item_quantity
@onready var details_panel = $Details_panel
@onready var item_name = $Details_panel/ItemName
@onready var item_type = $Details_panel/ItemType
@onready var item_effect = $Details_panel/ItemEffect
@onready var usage_panel = $Usage_Panel

#Slot item
var item = null 
var slot_index = -1 

 
#set index
func set_slot_index(new_index):
	slot_index = new_index

#show usage panel for player to use or drop items 
func _on_item_button_pressed() -> void:   #shows the usage panel
	if item != null:
		usage_panel.visible = !usage_panel.visible 

#Show item details on hover enter 
func _on_item_button_mouse_entered() -> void:
	if item != null:
		usage_panel.visible = false
		details_panel.visible = true

#Hide item details on hover exit 
func _on_item_button_mouse_exited() -> void:
	details_panel.visible = false
	
#default empty slot 
func set_empty():
	icon.texture = null 
	quantity_label.text = ""

	
#set slot items with it values 
func set_item(new_item):
	item = new_item #.duplicate(true)
	icon.texture = new_item["texture"]
	quantity_label.text = str(item["quantity"])
	item_name.text = str(item["name"])
	item_type.text = str(item["type"])
	if item["effect"] != "":
		item_effect.text = str("+", item["effect"])
	else:
		set_empty()
		item_effect.text = ""
	#update_assigment_status()


func _on_drop_button_pressed() -> void: #if pressed instinalize drop position to be equal to player position, check for valid drop position in area where player is, only if item is valid (don't want to drop nonexistent item 
	if item != null:
		var drop_position = Global.player_node.global_position
		var drop_offset = Vector2(0, 50)
		drop_offset = drop_offset.rotated(Global.player_node.rotation)
		Global.drop_item(item, drop_position + drop_offset)
		Global._remove_item(item["type"], item["effect"])
		usage_panel.visible = true
		



func _on_use_button_pressed() -> void: 
	usage_panel.visible = false
	if item != null and item["effect"] != "": #not empty & item has an effect 
		if Global.player_node:
			Global.player_node.apply_item_effect(item)
			Global._remove_item(item["type"], item["effect"])
		else:
			print("Player could not be found")
