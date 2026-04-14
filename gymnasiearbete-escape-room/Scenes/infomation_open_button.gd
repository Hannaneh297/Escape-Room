extends Button


@onready var info_box = $"../infobox"

func _on_pressed():
	info_box.visible = !info_box.visible
