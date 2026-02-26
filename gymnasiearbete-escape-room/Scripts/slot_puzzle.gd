extends Panel

var current_item = null


func place_item(item):
	if current_item: 
		swap_items(item)
	else:
		current_item = item
		item.current_slot = self 
		item.global_position = global_position

func swap_items(new_item):
	var old_item = current_item
	var old_slot = new_item.current_slot
	current_item = new_item   # Put new item here
	new_item.current_slot = self
	new_item.global_position = global_position
	if old_slot:     # Return old item
		old_slot.current_item = old_item 
		old_item.current_slot = old_slot
		old_item.global_position = old_slot.global_position
