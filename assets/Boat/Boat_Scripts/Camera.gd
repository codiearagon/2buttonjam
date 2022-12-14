extends Camera2D

func _process(delta: float) -> void:
	if get_node("../Boat") != null:
		position = get_node("../Boat/Center").global_position
