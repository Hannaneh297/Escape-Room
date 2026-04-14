extends Node

var inventory = []  #inventory items
var player_node: Node = null





@onready var inventory_slot_scene = preload("res://Scenes/Inventory/inventory_slot.tscn")


signal inventory_updated #scene & node refrences

func _ready():
	inventory.resize(15) #initializes the inventory with 28 slots (spread over 4 blocks per row)


func _add_item(item):  #adds item to inventory
		for i in range(15):
			#check if item exists in inventory and matches type & effect
			if inventory[i] != null and inventory[i]["type"] == item["type"] and inventory[i]["effect"] == item["effect"]:
				inventory[i]["quantity"] += item["quantity"]
				inventory_updated.emit() 
				print("item_added", inventory)  
				return true
			elif inventory[i] == null:
				inventory[i] = item.duplicate(true)
				inventory_updated.emit() 
				return true
		return false
	
func _remove_item(item_type , item_effect): #removes item from inventory based on type & effect
	for i in range(inventory.size()):
		if inventory[i] != null and inventory[i]["type"] == item_type and inventory[i]["effect"] == item_effect:
			inventory[i]["quantity"] -= 1
			if inventory[i]["quantity"] <= 0:
				inventory[i] = null
			inventory_updated.emit()
			return true
	return false
	


func set_player_reference(player): #set player reference for inventory interactions
	player_node = player
	

#placing of items when dropping, checks the position of items nearby are too close if so and drops
func adjust_drop_position(position):  
	var radius = 100
	var nearby_items = get_tree().get_nodes_in_group("Items")
	for item in nearby_items:
		if item.global_position.distance_to(position) < radius: 
			var random_offset = Vector2(randf_range(-radius, radius), randf_range(-radius, radius))
			position += random_offset
			break
	return position #will return the vaild drop position


func drop_item(item_data, drop_position): #actual drop function
	var item_scene = load(item_data["scene_path"]) #takes the item from saved scene path
	var item_instance = item_scene.instantiate()
	item_instance.set_item_data(item_data) #passes down the info
	drop_position = adjust_drop_position(drop_position) #adjusts so its not overlapping
	item_instance.global_position = drop_position #sets positon
	get_tree().current_scene.add_child(item_instance) #adds the items so its visible
