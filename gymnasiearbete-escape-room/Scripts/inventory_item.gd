@tool
extends Node2D


@export var item_type = ""
@export var item_name = ""
@export var item_texture: Texture
@export var item_effect = ""

@onready var Item_label = $Item_label
@onready var icon_sprite = $Sprite2D #scene-tree node refrences


var scene_path: String = "res://Scenes/Inventory/inventory_Item.tscn"

var player_in_range = false
var label = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Engine.is_editor_hint(): 
		icon_sprite.texture = item_texture 



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Engine.is_editor_hint(): #game in editor
		icon_sprite.texture = item_texture
	#Add item to inventory if player presses "A" within range
	if player_in_range and Input.is_action_just_pressed("add_item"): # if player close and picks up
		pickup_item()


# Add item to inventory 
func pickup_item(): #0.53
	var item = {
		"quantity" : 1,
		"type": item_type, #item
		"name": item_name,
		"texture": item_texture,
		"effect": item_effect,
		"scene_path": scene_path
	}
	
	if Global.player_node: 
		Global._add_item(item) #add to player inventory
		self.queue_free() #delte form world agfter pick up
		

#if player is in range, show ui and make item pickable 
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"): 
		player_in_range = true
		Item_label.visible = true

# if player is in range, hide ui and don't make item pickable
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		Item_label.visible = false 
		

func set_item_data(data):
	item_type = data["type"]
	item_name= data["name"]
	item_effect = data["effect"]
	item_texture= data["texture"]
	
	
