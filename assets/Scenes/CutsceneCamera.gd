extends Camera2D

func _process(delta: float) -> void:
	if get_node("../Boss") != null:
		position = get_node("../Boss/Center").global_position
		
