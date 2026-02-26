extends PanelContainer

@onready var icon: TextureRect = $ItemIcon

var item_texture: Texture2D = null


func set_item(texture: Texture2D):
	item_texture = texture
	icon.texture = texture


func clear_item():
	item_texture = null
	icon.texture = null


func has_item() -> bool:
	return item_texture != null
